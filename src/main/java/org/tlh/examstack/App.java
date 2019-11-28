package org.tlh.examstack;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Import;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.tlh.examstack.module.sys.config.FreeMarkerConfig;
import org.tlh.examstack.module.sys.config.mvc.TlhMvcConfig;
import org.tlh.examstack.module.sys.config.security.ShiroConfig;

@SpringBootApplication
@EnableTransactionManagement
@EnableJpaRepositories(basePackages = "org.tlh.examstack.module.**.repository")
@Import({ShiroConfig.class, TlhMvcConfig.class, FreeMarkerConfig.class})
public class App {

    public static void main(String[] args){
        SpringApplication.run(App.class,args);
    }

}

