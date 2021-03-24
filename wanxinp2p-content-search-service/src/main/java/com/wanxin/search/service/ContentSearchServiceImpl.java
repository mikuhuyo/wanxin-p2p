package com.wanxin.search.service;

import com.wanxin.api.search.model.ProjectQueryParamsDTO;
import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.common.domain.PageVO;
import org.apache.commons.lang.StringUtils;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Service
public class ContentSearchServiceImpl implements ContentSearchService {
    @Value("${wanxinp2p.es.index}")
    private String projectIndex;
    @Autowired
    private RestHighLevelClient restHighLevelClient;

    @Override
    public PageVO<ProjectDTO> queryProjectIndex(ProjectQueryParamsDTO queryParamsDTO, Integer pageNo, Integer pageSize, String sortBy, String order) {
        // 创建搜索请求对象
        SearchRequest searchRequest = new SearchRequest(projectIndex);

        // 查询条件
        BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();

        if (queryParamsDTO.getName() != null) {
            boolQueryBuilder.must(QueryBuilders.termQuery("name", queryParamsDTO.getName()));
        }

        if (queryParamsDTO.getStartPeriod() != null) {
            boolQueryBuilder.must(QueryBuilders.rangeQuery("period").gte(queryParamsDTO.getStartPeriod()));
        }

        if (queryParamsDTO.getEndPeriod() != null) {
            boolQueryBuilder.must(QueryBuilders.rangeQuery("period").lte(queryParamsDTO.getEndPeriod()));
        }

        // 默认为满标查询
        boolQueryBuilder.must(QueryBuilders.termQuery("projectstatus", "FULLY"));

        // 精确匹配状态为满标
        if (queryParamsDTO.getProjectStatus() != null) {
            boolQueryBuilder.must(QueryBuilders.termQuery("projectstatus", "FULLY"));
        }

        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.query(boolQueryBuilder);

        if (StringUtils.isNotBlank(sortBy) && StringUtils.isNotBlank(order)) {
            if (order.toLowerCase().equals("asc")) {
                searchSourceBuilder.sort(sortBy, SortOrder.ASC);
            }

            if (order.toLowerCase().equals("desc")) {
                searchSourceBuilder.sort(sortBy, SortOrder.DESC);
            }
        } else {
            searchSourceBuilder.sort("createdate", SortOrder.DESC);
        }

        // 设置分页信息
        searchSourceBuilder.from((pageNo - 1) * pageSize);
        searchSourceBuilder.size(pageSize);
        // 完成封装
        searchRequest.source(searchSourceBuilder);
        List<ProjectDTO> list = new ArrayList<>();
        PageVO<ProjectDTO> pageVO = new PageVO<>();
        try {
            // 执行搜索
            SearchResponse searchResponse = restHighLevelClient.search(searchRequest, RequestOptions.DEFAULT);
            // 获取响应结果
            SearchHits hits = searchResponse.getHits();
            // 匹配的总记录数
            long totalHits = hits.getTotalHits().value;
            pageVO.setTotal(totalHits);
            // 获取匹配数据
            SearchHit[] searchHits = hits.getHits();

            // 循环封装DTO
            for (SearchHit hit : searchHits) {
                Map<String, Object> sourceAsMap = hit.getSourceAsMap();
                String projectstatus = (String) sourceAsMap.get("projectstatus");
                ProjectDTO projectDTO = new ProjectDTO();
                Double amount = (Double) sourceAsMap.get("amount");
                Integer period = Integer.parseInt(sourceAsMap.get("period").toString());
                String name = (String) sourceAsMap.get("name");
                String description = (String) sourceAsMap.get("description");
                projectDTO.setAmount(new BigDecimal(amount));
                projectDTO.setProjectStatus(projectstatus);
                projectDTO.setPeriod(period);
                projectDTO.setName(name);
                projectDTO.setDescription(description);
                projectDTO.setId((Long) sourceAsMap.get("id"));
                projectDTO.setAnnualRate(new BigDecimal((Double) sourceAsMap.get("annualrate")));
                list.add(projectDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        // 封装为PageVO对象并返回
        pageVO.setContent(list);
        pageVO.setPageNo(pageNo);
        pageVO.setPageSize(pageSize);
        return pageVO;
    }
}
