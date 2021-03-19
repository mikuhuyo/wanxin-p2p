package com.wanxin.transaction.agent;

import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.api.transaction.model.ProjectQueryDTO;
import com.wanxin.common.domain.BusinessException;
import com.wanxin.common.domain.CommonErrorCode;
import com.wanxin.common.domain.PageVO;
import com.wanxin.common.domain.RestResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@FeignClient(
        value = "content-search-service",
        fallback = ContentSearchApiAgentFallback.class,
        configuration = {ContentSearchApiAgentConfiguration.class}
)
public interface ContentSearchApiAgent {
    @PostMapping(value = "/search/l/projects/indexes/q")
    RestResponse<PageVO<ProjectDTO>> queryProjectIndex(@RequestBody ProjectQueryDTO projectQueryDTO, @RequestParam("pageNo") Integer pageNo, @RequestParam("pageSize") Integer pageSize, @RequestParam(value = "sortBy", required = false) String sortBy, @RequestParam(value = "order", required = false) String order);
}

class ContentSearchApiAgentFallback implements ContentSearchApiAgent {

    @Override
    public RestResponse<PageVO<ProjectDTO>> queryProjectIndex(ProjectQueryDTO projectQueryDTO, Integer pageNo, Integer pageSize, String sortBy, String order) {
        throw new BusinessException(CommonErrorCode.E_999993);
    }
}

class ContentSearchApiAgentConfiguration {
    @Bean
    public ContentSearchApiAgentFallback contentSearchApiAgentFallback() {
        return new ContentSearchApiAgentFallback();
    }
}
