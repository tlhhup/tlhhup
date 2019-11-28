package org.tlh.examstack.module.sys.config.security;

import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.event.EventBus;
import org.apache.shiro.event.support.DefaultEventBus;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.spring.web.config.DefaultShiroFilterChainDefinition;
import org.apache.shiro.spring.web.config.ShiroFilterChainDefinition;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.tlh.examstack.module.sys.config.security.filter.FormAuthenticationFilter;
import org.tlh.examstack.module.sys.service.UserService;

@Configuration
@Import({ShiroWebConfiguration.class,ShiroWebFilterConfiguration.class,ShiroAnnotationProcessorConfiguration.class})
public class ShiroConfig {

    @Bean
    public FormAuthenticationFilter formAuthenticationFilter(UserService userService){
        FormAuthenticationFilter formAuthenticationFilter=new FormAuthenticationFilter();
        formAuthenticationFilter.setUserService(userService);
        return formAuthenticationFilter;
    }

    @Bean
    public Realm realm(){
        TlhShiroRealm realm=new TlhShiroRealm();
        HashedCredentialsMatcher credentialsMatcher=new HashedCredentialsMatcher();
        credentialsMatcher.setHashIterations(5);
        credentialsMatcher.setHashAlgorithmName(Md5Hash.ALGORITHM_NAME);
        realm.setCredentialsMatcher(credentialsMatcher);
        return realm;
    }

    @Bean
    public ShiroFilterChainDefinition shiroFilterChainDefinition(){
        DefaultShiroFilterChainDefinition shiroFilterChainDefinition=new DefaultShiroFilterChainDefinition();
        shiroFilterChainDefinition.addPathDefinition("/login","authc");
        shiroFilterChainDefinition.addPathDefinition("/dashboard/**","user");//该过滤器，是只用用户登录就可以访问
        shiroFilterChainDefinition.addPathDefinition("/sys/**","user");//该过滤器，是只用用户登录就可以访问
        //shiroFilterChainDefinition.addPathDefinition("/sys/**","perms[sys:*]");//该过滤器，是只有用户具有相应的权限才可以访问 todo 该位置存在用户登录之后手动访问无权限的资源的问题
        shiroFilterChainDefinition.addPathDefinition("/logout","anon");
        return shiroFilterChainDefinition;
    }

    @Bean
    public EventBus eventBus(){
        return new DefaultEventBus();
    }

}
