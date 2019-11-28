package org.tlh.examstack.module.sys.config.security;

import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.tlh.examstack.module.sys.entity.User;
import org.tlh.examstack.module.sys.service.UserService;

import java.util.HashSet;

public class TlhShiroRealm extends AuthorizingRealm {

    @Autowired
    private UserService mUserService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        User user = (User) principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo authorizationInfo=new SimpleAuthorizationInfo();
        authorizationInfo.setRoles(new HashSet<>(mUserService.findRolesByUserName(user.getUserName())));
        authorizationInfo.setStringPermissions(new HashSet<>(mUserService.findMenusByUserName(user.getUserName())));
        return authorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String username = token.getPrincipal().toString();
        User user = this.mUserService.findUserByUserName(username);
        if (user != null) {
            if (user.getEnabled()) {
                SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user, user.getPassword(), ByteSource.Util.bytes(user.getSalt()), getName());
                return authenticationInfo;
            } else {
                throw new DisabledAccountException("账户不可用");
            }
        } else {
            throw new AccountException("用户名错误");
        }
    }
}
