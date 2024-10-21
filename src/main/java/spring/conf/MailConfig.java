package spring.conf;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@Configuration
public class MailConfig {

    @Bean
    public JavaMailSender mailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.naver.com"); // 메일 서버 호스트
        mailSender.setPort(465); // 메일 서버 포트번호
        mailSender.setUsername("ghks248"); // 자신의 이메일 아이디
        mailSender.setPassword("kjh960707!"); // 자신의 비밀번호

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtps.checkserveridentity", "true");
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtps.ssl.trust", "*");
        props.put("mail.debug", "true");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        return mailSender;
    }
}
