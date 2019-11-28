package org.tlh.examstack.module.sys.config.security;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;

import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.spring.web.config.AbstractShiroWebFilterConfiguration;
import org.apache.shiro.web.servlet.AbstractShiroFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.embedded.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.tlh.examstack.module.sys.config.security.filter.FormAuthenticationFilter;

@Configuration
@ConditionalOnProperty(name = "shiro.web.enabled", matchIfMissing = true)
public class ShiroWebFilterConfiguration extends AbstractShiroWebFilterConfiguration {

    @Autowired
    private FormAuthenticationFilter formAuthenticationFilter;

    @Bean
    @ConditionalOnMissingBean
    @Override
    protected ShiroFilterFactoryBean shiroFilterFactoryBean() {
        ShiroFilterFactoryBean shiroFilterFactoryBean = super.shiroFilterFactoryBean();
        //设置自定义的过滤器
        Map<String,Filter> filters=new HashMap<>();
        filters.put("authc",formAuthenticationFilter);
        shiroFilterFactoryBean.setFilters(filters);
		return shiroFilterFactoryBean;
    }

    @SuppressWarnings("deprecation")
	@Bean(name = "filterShiroFilterRegistrationBean")
    @ConditionalOnMissingBean
    protected FilterRegistrationBean filterShiroFilterRegistrationBean() throws Exception {

        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        filterRegistrationBean.setFilter((AbstractShiroFilter) shiroFilterFactoryBean().getObject());
        filterRegistrationBean.setOrder(1);

        return filterRegistrationBean;
    }
}
