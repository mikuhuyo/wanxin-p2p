package com.wanxin.consumer.controller;

import com.alibaba.fastjson.JSON;
import com.wanxin.api.consumer.ConsumerAPI;
import com.wanxin.api.consumer.model.*;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.consumer.common.SecurityUtil;
import com.wanxin.consumer.service.BankCardService;
import com.wanxin.consumer.service.ConsumerDetailsService;
import com.wanxin.consumer.service.ConsumerService;
import com.wanxin.consumer.utils.BaiDuOrcIdCardUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Slf4j
@RestController
@Api(value = "用户服务API", tags = "Consumer")
public class ConsumerController implements ConsumerAPI {
    @Value("${minio.appId}")
    private String appId;
    @Value("${minio.accessKey}")
    private String accessKey;
    @Value("${minio.secretKey}")
    private String secretKey;

    @Autowired
    private ConsumerService consumerService;
    @Autowired
    private BankCardService bankCardService;
    @Autowired
    private ConsumerDetailsService consumerDetailsService;

    @Value("${depository.url}")
    private String depositoryUrl;
    private final OkHttpClient okHttpClient = new OkHttpClient().newBuilder().build();

    private RestResponse<BalanceDetailsDTO> getBalanceFromDepository(String userNo) {
        String url = depositoryUrl + "/balance-details/" + userNo;
        Request request = new Request.Builder().url(url).build();
        try (Response response = okHttpClient.newCall(request).execute()) {
            if (response.isSuccessful()) {
                assert response.body() != null;
                String responseBody = response.body().string();
                BalanceDetailsDTO balanceDetailsDTO = JSON.parseObject(responseBody, BalanceDetailsDTO.class);
                return RestResponse.success(balanceDetailsDTO);
            }
        } catch (IOException e) {
            log.warn("调用存管系统{}获取余额失败 ", url);
        }
        return RestResponse.validfail("获取失败");
    }

    private RestResponse<BigDecimal> getBankCardDetailsFromDepository(String bankCardId) {
        String url = depositoryUrl + "/bank-cards/card-number/" + bankCardId;
        Request request = new Request.Builder().url(url).build();
        try(Response response = okHttpClient.newCall(request).execute()) {
            if (response.isSuccessful()) {
                assert response.body() != null;
                String body = response.body().string();
                Map map = JSON.parseObject(body, Map.class);
                return RestResponse.success(new BigDecimal(map.get("result").toString()));
            }
        } catch (IOException e) {
            log.warn("调用存管系统{}获取银行卡明细失败 ", url);
        }
        return RestResponse.validfail("获取银行卡明细失败");
    }

    @Override
    @GetMapping("/my/bank-card-details")
    @ApiOperation("获取用户银行卡明细")
    public RestResponse<BigDecimal> getMyBankCardDetails() {
        String mobile = SecurityUtil.getUser().getMobile();
        return getBankCardDetailsFromDepository(
                bankCardService.getByConsumerId(consumerService.getConsumerByMobile(mobile).getId()).getCardNumber()
        );
    }

    @Override
    @GetMapping("/l/bank-card-details/{id}")
    @ApiOperation("获取用户银行卡明细")
    @ApiImplicitParam(name = "id", value = "用户ID", required = true, dataType = "long")
    public RestResponse<BigDecimal> getBankCardDetails(@PathVariable("id") Long id) {
        return getBankCardDetailsFromDepository(bankCardService.getByConsumerId(id).getCardNumber());
    }

    @Override
    @GetMapping("/my/balances")
    @ApiOperation("获取当前登录用户余额信息")
    public RestResponse<BalanceDetailsDTO> getMyBalance() {
        return getBalanceFromDepository(consumerService.getConsumerByMobile(SecurityUtil.getUser().getMobile()).getUserNo());
    }

    @Override
    @GetMapping("/l/balances/{userNo}")
    @ApiOperation("获取用户可用余额")
    @ApiImplicitParam(name = "userNo", value = "用户编码", required = true, dataType = "String")
    public RestResponse<BalanceDetailsDTO> getBalance(@PathVariable("userNo") String userNo) {
        return getBalanceFromDepository(userNo);
    }

    @Override
    @GetMapping("/my/borrowers/{id}")
    @ApiOperation("获取借款人用户信息")
    @ApiImplicitParam(name = "id", value = "用户标识", required = true, dataType = "Long", paramType = "path")
    public RestResponse<BorrowerDTO> getBorrower(@PathVariable("id") Long id) {
        return RestResponse.success(consumerService.getBorrower(id));
    }

    @Override
    @PostMapping("/my/saveConsumerDetails")
    @ApiOperation(value = "保存用户详细信息", notes = "主要存储身份证文件标识")
    @ApiImplicitParam(name = "consumerDetailsDTO", value = "用户详细信息", dataType = "ConsumerDetailsDTO", paramType = "body")
    public RestResponse<String> saveConsumerDetails(@RequestBody ConsumerDetailsDTO consumerDetailsDTO) {
        consumerDetailsService.createConsumerDetails(consumerDetailsDTO, SecurityUtil.getUser().getMobile());
        return RestResponse.success("保存成功");
    }

    @Override
    @GetMapping("/my/applyUploadCertificate")
    @ApiOperation("获取文件上传密钥对")
    public RestResponse<FileTokenDTO> applyUploadCertificate() {
        FileTokenDTO fileTokenDTO = new FileTokenDTO();
        fileTokenDTO.setAppId(appId);
        fileTokenDTO.setAccessKey(accessKey);
        fileTokenDTO.setSecretKey(secretKey);

        return RestResponse.success(fileTokenDTO);
    }

    @Override
    @PostMapping("/my/imageRecognition")
    @ApiOperation("提交身份证图片给百度AI进行识别")
    @ApiImplicitParam(name = "flag", value = "正反面", required = true, dataType = "string", paramType = "query")
    public RestResponse<IdCardDTO> imageRecognition(@RequestParam("file") MultipartFile multipartFile, @RequestParam("flag") String flag) throws IOException {
        String info = null;
        if ("front".equals(flag)) {
            info = BaiDuOrcIdCardUtil.idCardFront(multipartFile.getBytes());
        }

        if ("back".equals(flag)) {
            // 我们并不需要识别国徽面.
            // info = BaiDuOrcIdCardUtil.idCardBack(multipartFile.getBytes());
            return RestResponse.success();
        }

        JSONObject jsonObject = new JSONObject(info);

        IdCardDTO idCardDTO = new IdCardDTO();
        idCardDTO.setFlag(flag);
        idCardDTO.setIdCardNo(jsonObject.getJSONObject("words_result").getJSONObject("公民身份号码").getString("words"));
        idCardDTO.setIdCardName(jsonObject.getJSONObject("words_result").getJSONObject("姓名").getString("words"));
        idCardDTO.setIdCardAddress(jsonObject.getJSONObject("words_result").getJSONObject("住址").getString("words"));

        return RestResponse.success(idCardDTO);
    }

    @Override
    @GetMapping("/my/withdraw-records")
    @ApiOperation("生成提现请求数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "amount", value = "金额", required = true, dataType = "string", paramType = "query"),
            @ApiImplicitParam(name = "callbackUrl", value = "通知结果回调URL", required = true, dataType = "string", paramType = "query")
    })
    public RestResponse<GatewayRequest> createWithdrawRecord(@RequestParam("amount") String amount, @RequestParam("callbackUrl") String callbackUrl) {
        return consumerService.createWithdrawRecord(amount, callbackUrl, SecurityUtil.getUser().getMobile());
    }

    @Override
    @GetMapping("/my/recharge-records")
    @ApiOperation("生成充值请求数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "amount", value = "金额", required = true, dataType = "string", paramType = "query"),
            @ApiImplicitParam(name = "callbackUrl", value = "通知结果回调URL", required = true, dataType = "string", paramType = "query")
    })
    public RestResponse<GatewayRequest> createRechargeRecord(@RequestParam("amount") String amount, @RequestParam("callbackUrl") String callbackUrl) {
        return consumerService.createRechargeRecord(amount, callbackUrl, SecurityUtil.getUser().getMobile());
    }

    // @Override
    // @ApiOperation("获取用户余额信息")
    // @GetMapping("/my/balances")
    // public RestResponse<BalanceDetailsDTO> getBalances() throws IOException {
    //     String userNo = consumerService.getConsumerByMobile(SecurityUtil.getUser().getMobile()).getUserNo();
    //     return RestResponse.success(consumerService.getBalanceDetailsByUserNo(userNo));
    // }

    @Override
    @GetMapping("/my/consumers")
    @ApiOperation("获取用户信息")
    public RestResponse<ConsumerDTO> getConsumer() {
        return RestResponse.success(consumerService.getConsumerByMobile(SecurityUtil.getUser().getMobile()));
    }

    @Override
    @GetMapping("/my/bank-cards")
    @ApiOperation("获取用户银行卡信息")
    public RestResponse<BankCardDTO> getBankCard() {
        return RestResponse.success(bankCardService.getByUserMobile(SecurityUtil.getUser().getMobile()));
    }

    @Override
    @PostMapping("/my/consumers")
    @ApiOperation("生成开户请求数据")
    @ApiImplicitParam(name = "consumerRequest", value = "开户信息", required = true, dataType = "ConsumerRequest", paramType = "body")
    public RestResponse<GatewayRequest> createConsumer(@RequestBody ConsumerRequest consumerRequest) throws IOException {
        consumerRequest.setMobile(SecurityUtil.getUser().getMobile());
        return consumerService.createConsumer(consumerRequest);
    }

    @Override
    @PostMapping("/consumers")
    @ApiOperation("用户注册")
    @ApiImplicitParam(name = "consumerRegisterDTO", value = "注册信息", required = true, dataType = "AccountRegisterDTO", paramType = "body")
    public RestResponse register(@RequestBody ConsumerRegisterDTO consumerRegisterDTO) {
        consumerService.register(consumerRegisterDTO);
        return RestResponse.success();
    }
}
