package org.tlh.examstack.module.sys.config.security.filter;

import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.tlh.examstack.module.sys.entity.User;
import org.tlh.examstack.module.sys.service.UserService;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.util.Date;

public class FormAuthenticationFilter extends org.apache.shiro.web.filter.authc.FormAuthenticationFilter {

    private UserService userService;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        User user = subject.getPrincipals().oneByType(User.class);
        user.setLastLoginTime(new Date());
        userService.updateLastLogin(user);
        return super.onLoginSuccess(token, subject, request, response);
    }
}
