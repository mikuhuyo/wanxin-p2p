package com.wanxin.uaa.repository;

import com.wanxin.uaa.domain.OauthClientDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Repository("oauthRepositoryJdbc")
public class OauthRepositoryJdbc implements OauthRepository {
    private static OauthClientDetailsRowMapper oauthClientDetailsRowMapper = new OauthClientDetailsRowMapper();

    @Autowired
    private JdbcTemplate jdbcTemplate;


    @Override
    public OauthClientDetails findOauthClientDetails(String clientId) {
        final String sql = " select * from oauth_client_details where  client_id = ? ";
        final List<OauthClientDetails> list = this.jdbcTemplate.query(sql, new Object[]{clientId}, oauthClientDetailsRowMapper);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<OauthClientDetails> findAllOauthClientDetails() {
        final String sql = " select * from oauth_client_details order by create_time desc ";
        return this.jdbcTemplate.query(sql, oauthClientDetailsRowMapper);
    }

    @Override
    public void updateOauthClientDetailsArchive(String clientId, boolean archive) {
        final String sql = " update oauth_client_details set archived = ? where client_id = ? ";
        this.jdbcTemplate.update(sql, archive, clientId);
    }

    @Override
    public void saveOauthClientDetails(final OauthClientDetails clientDetails) {
        final String sql = " insert into oauth_client_details(client_id,resource_ids,client_secret,scope,authorized_grant_types,web_server_redirect_uri," +
                " authorities,access_token_validity,refresh_token_validity,additional_information,trusted,autoapprove) values (?,?,?,?,?,?,?,?,?,?,?,?)";

        this.jdbcTemplate.update(sql, ps -> {
            ps.setString(1, clientDetails.clientId());
            ps.setString(2, clientDetails.resourceIds());

            ps.setString(3, clientDetails.clientSecret());
            ps.setString(4, clientDetails.scope());

            ps.setString(5, clientDetails.authorizedGrantTypes());
            ps.setString(6, clientDetails.webServerRedirectUri());

            ps.setString(7, clientDetails.authorities());
            ps.setObject(8, clientDetails.accessTokenValidity());

            ps.setObject(9, clientDetails.refreshTokenValidity());
            ps.setString(10, clientDetails.additionalInformation());

            ps.setBoolean(11, clientDetails.trusted());
            ps.setString(12, clientDetails.autoApprove());

        });
    }
}
