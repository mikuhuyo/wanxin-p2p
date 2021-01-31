package com.wanxin.uaa.domain;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.oauth2.provider.token.UserAuthenticationConverter;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class UnifiedUserAuthenticationConverter implements UserAuthenticationConverter {

    private Collection<? extends GrantedAuthority> defaultAuthorities;

    private UserDetailsService userDetailsService;

    /**
     * Optional {@link UserDetailsService} to use when extracting an {@link Authentication} from the incoming map.
     *
     * @param userDetailsService the userDetailsService to set
     */
    public void setUserDetailsService(UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    /**
     * Default value for authorities if an Authentication is being created and the input has no data for authorities.
     * Note that unless this property is set, the default Authentication created by {@link #extractAuthentication(Map)}
     * will be unauthenticated.
     *
     * @param defaultAuthorities the defaultAuthorities to set. Default null.
     */
    public void setDefaultAuthorities(String[] defaultAuthorities) {
        this.defaultAuthorities = AuthorityUtils.commaSeparatedStringToAuthorityList(StringUtils
                .arrayToCommaDelimitedString(defaultAuthorities));
    }

    public Map<String, ?> convertUserAuthentication(Authentication authentication) {
        Map<String, Object> response = new LinkedHashMap<String, Object>();
        response.put(USERNAME, authentication.getName());
        if (authentication.getAuthorities() != null && !authentication.getAuthorities().isEmpty()) {
            response.put(AUTHORITIES, AuthorityUtils.authorityListToSet(authentication.getAuthorities()));
        }

        if (authentication.getPrincipal() instanceof UnifiedUserDetails) {
            UnifiedUserDetails unifiedUserDetails = (UnifiedUserDetails) authentication.getPrincipal();
            response.put("mobile", unifiedUserDetails.getMobile());
            response.put("tenant_id", unifiedUserDetails.getTenantId());
            response.put("department_id", unifiedUserDetails.getDepartmentId());
            response.put("user_authorities", unifiedUserDetails.getUserAuthorities());
            response.put("payload", unifiedUserDetails.getPayload());
        }
        return response;
    }

    public Authentication extractAuthentication(Map<String, ?> map) {
        if (map.containsKey(USERNAME)) {
            Object principal = map.get(USERNAME);
            Collection<? extends GrantedAuthority> authorities = getAuthorities(map);
            if (userDetailsService != null) {
                UserDetails user = userDetailsService.loadUserByUsername((String) map.get(USERNAME));
                authorities = user.getAuthorities();
                principal = user;
            }

            //UnifiedUserDetails unifiedUserDetails = new UnifiedUserDetails((String)map.get(USERNAME),"N/A",new ArrayList<>(authorities));
            UnifiedUserDetails unifiedUserDetails = new UnifiedUserDetails((String) map.get(USERNAME), "N/A", new ArrayList<>());

            unifiedUserDetails.setTenantId((String) map.get("tenant_id"));
            unifiedUserDetails.setMobile((String) map.get("mobile"));
            unifiedUserDetails.setDepartmentId((String) map.get("department_id"));
            //unifiedUserDetails.setUserAuthorities((Map<String, List<String>>) map.get("user_authorities"));
            unifiedUserDetails.setPayload((Map<String, Object>) map.get("payload"));

            return new UsernamePasswordAuthenticationToken(unifiedUserDetails, "N/A", authorities);
        }
        return null;
    }

    private Collection<? extends GrantedAuthority> getAuthorities(Map<String, ?> map) {
        if (!map.containsKey(AUTHORITIES)) {
            return defaultAuthorities;
        }
        Object authorities = map.get(AUTHORITIES);
        if (authorities instanceof String) {
            return AuthorityUtils.commaSeparatedStringToAuthorityList((String) authorities);
        }
        if (authorities instanceof Collection) {
            return AuthorityUtils.commaSeparatedStringToAuthorityList(StringUtils
                    .collectionToCommaDelimitedString((Collection<?>) authorities));
        }
        throw new IllegalArgumentException("Authorities must be either a String or a Collection");
    }
}
