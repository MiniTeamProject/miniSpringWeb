package naver.service.impl;

import java.io.InputStream;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import spring.conf.NCPConfiguration;

@Service
public class NCPObjectStorageService implements naver.service.ObjectStorageService {
    final AmazonS3 amazonS3;

    public NCPObjectStorageService(NCPConfiguration ncpConfiguration) {
        amazonS3 = AmazonS3ClientBuilder
                .standard()
                .withEndpointConfiguration(
                        new AwsClientBuilder.EndpointConfiguration(
                                ncpConfiguration.getEndPoint(), ncpConfiguration.getRegionName()))
                .withCredentials(
                        new AWSStaticCredentialsProvider(
                                new BasicAWSCredentials(
                                        ncpConfiguration.getAccessKey(), ncpConfiguration.getSecretKey())))
                .build();
    }

    @Override
    public String uploadFile(String bucketName, String directoryPath, MultipartFile multipartFile) {
        try (InputStream inputStream = multipartFile.getInputStream()) {
            String imageFileName = UUID.randomUUID().toString() + "_" + multipartFile.getOriginalFilename();
            
            ObjectMetadata objectMetadata = new ObjectMetadata();
            objectMetadata.setContentType(multipartFile.getContentType());
            objectMetadata.setContentLength(multipartFile.getSize()); // 파일 크기 설정
            
            PutObjectRequest putObjectRequest =
                    new PutObjectRequest(bucketName,
                            directoryPath + imageFileName,
                            inputStream,
                            objectMetadata)
                            .withCannedAcl(CannedAccessControlList.PublicRead); // 공개 읽기 권한 설정
            
            amazonS3.putObject(putObjectRequest);
            
            // NCP Object Storage에서 파일에 접근할 수 있는 URL 생성
            return amazonS3.getUrl(bucketName, directoryPath + imageFileName).toString();

        } catch (Exception e) {
            throw new RuntimeException("파일 업로드 실패: " + e.getMessage(), e);
        }
    }
}
