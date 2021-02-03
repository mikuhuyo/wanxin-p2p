package com.wanxin.consumer.utils;

import com.alibaba.fastjson.JSONObject;
import com.wanxin.common.domain.BusinessException;
import com.wanxin.consumer.common.ConsumerErrorCode;
import lombok.extern.slf4j.Slf4j;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Map;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Slf4j
@Component
public class CheckBankCardUtil {
    private String bankCode;
    private String bankName;

    public String checkBankCard(String cardNumber) throws IOException {
        OkHttpClient client = new OkHttpClient().newBuilder().build();
        Request request = new Request.Builder()
                .url("https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?_input_charset=utf-8&cardNo=" + cardNumber + "&cardBinCheck=true")
                .method("GET", null)
                .addHeader("Cookie", "JSESSIONID=E9479B7122FF4D7DFD789422E5F2FE5B; spanner=QPUjmjZ36a0Oy1dCyZ/e4NZpyo/Q9t1O4EJoL7C0n0A=")
                .build();
        Response execute = client.newCall(request).execute();
        assert execute.body() != null;
        String response = execute.body().string();

        log.info("银行卡校验-{}", response);

        Map map = JSONObject.parseObject(response, Map.class);
        if ((Boolean) map.get("validated")) {
            this.bankCode = map.get("bank").toString();

            if ("CCB".equals(this.bankCode)) {
                this.bankName = "中国建设银行";
            } else if ("PSBC".equals(this.bankCode)) {
                this.bankName = "中国邮政储蓄银行";
            } else if ("ABC".equals(this.bankCode)) {
                this.bankName = "中国农业银行";
            } else if ("BOC".equals(this.bankCode)) {
                this.bankName = "中国银行";
            } else if ("COMM".equals(this.bankCode)) {
                this.bankName = "中国交通银行";
            } else if ("CMB".equals(this.bankCode)) {
                this.bankName = "招商银行";
            } else if ("CMBC".equals(this.bankCode)) {
                this.bankName = "中国民生银行";
            } else if ("CEB".equals(this.bankCode)) {
                this.bankName = "中国光大银行";
            } else if ("CITIC".equals(this.bankCode)) {
                this.bankName = "中信银行";
            } else if ("HXBANK".equals(this.bankCode)) {
                this.bankName = "华夏银行";
            } else if ("SPABANK".equals(this.bankCode)) {
                this.bankName = "深发/平安银行";
            } else if ("CIB".equals(this.bankCode)) {
                this.bankName = "兴业银行";
            } else if ("SHBANK".equals(this.bankCode)) {
                this.bankName = "上海银行";
            } else if ("SPDB".equals(this.bankCode)) {
                this.bankName = "浦东发展银行";
            } else if ("GDB".equals(this.bankCode)) {
                this.bankName = "广发银行";
            } else if ("BOHAIB".equals(this.bankCode)) {
                this.bankName = "渤海银行";
            } else if ("GCB".equals(this.bankCode)) {
                this.bankName = "广州银行";
            } else if ("JHBANK".equals(this.bankCode)) {
                this.bankName = "金华银行";
            } else if ("WZCB".equals(this.bankCode)) {
                this.bankName = "温州银行";
            } else if ("HSBANK".equals(this.bankCode)) {
                this.bankName = "徽商银行";
            } else if ("JSBANK".equals(this.bankCode)) {
                this.bankName = "江苏银行";
            } else if ("NJCB".equals(this.bankCode)) {
                this.bankName = "南京银行";
            } else if ("NBBANK".equals(this.bankCode)) {
                this.bankName = "宁波银行";
            } else if ("BJBANK".equals(this.bankCode)) {
                this.bankName = "北京银行";
            } else if ("BJRCB".equals(this.bankCode)) {
                this.bankName = "北京农村商业银行";
            } else if ("HSBC".equals(this.bankCode)) {
                this.bankName = "汇丰银行";
            } else if ("SCB".equals(this.bankCode)) {
                this.bankName = "渣打银行";
            } else if ("CITI".equals(this.bankCode)) {
                this.bankName = "花旗银行";
            } else if ("HKBEA".equals(this.bankCode)) {
                this.bankName = "东亚银行";
            } else if ("GHB".equals(this.bankCode)) {
                this.bankName = "广东华兴银行";
            } else if ("SRCB".equals(this.bankCode)) {
                this.bankName = "深圳农村商业银行";
            } else if ("GZRCU".equals(this.bankCode)) {
                this.bankName = "广州农村商业银行股份有限公司";
            } else if ("DRCBCL".equals(this.bankCode)) {
                this.bankName = "东莞农村商业银行";
            } else if ("BOD".equals(this.bankCode)) {
                this.bankName = "东莞市商业银行";
            } else if ("GDRCC".equals(this.bankCode)) {
                this.bankName = "广东省农村信用社联合社";
            } else if ("DSB".equals(this.bankCode)) {
                this.bankName = "大新银行";
            } else if ("WHB".equals(this.bankCode)) {
                this.bankName = "永亨银行";
            } else if ("DBS".equals(this.bankCode)) {
                this.bankName = "星展银行香港有限公司";
            } else if ("EGBANK".equals(this.bankCode)) {
                this.bankName = "恒丰银行";
            } else if ("TCCB".equals(this.bankCode)) {
                this.bankName = "天津市商业银行";
            } else if ("CZBANK".equals(this.bankCode)) {
                this.bankName = "浙商银行";
            } else if ("NCB".equals(this.bankCode)) {
                this.bankName = "南洋商业银行";
            } else if ("XMBANK".equals(this.bankCode)) {
                this.bankName = "厦门银行";
            } else if ("FJHXBC".equals(this.bankCode)) {
                this.bankName = "福建海峡银行";
            } else if ("JLBANK".equals(this.bankCode)) {
                this.bankName = "吉林银行";
            } else if ("HKB".equals(this.bankCode)) {
                this.bankName = "汉口银行";
            } else if ("SJBANK".equals(this.bankCode)) {
                this.bankName = "盛京银行";
            } else if ("DLB".equals(this.bankCode)) {
                this.bankName = "大连银行";
            } else if ("BHB".equals(this.bankCode)) {
                this.bankName = "河北银行";
            } else if ("URMQCCB".equals(this.bankCode)) {
                this.bankName = "乌鲁木齐市商业银行";
            } else if ("SXCB".equals(this.bankCode)) {
                this.bankName = "绍兴银行";
            } else if ("CDCB".equals(this.bankCode)) {
                this.bankName = "成都商业银行";
            } else if ("FSCB".equals(this.bankCode)) {
                this.bankName = "抚顺银行";
            } else if ("ZZBANK".equals(this.bankCode)) {
                this.bankName = "郑州银行";
            } else if ("NXBANK".equals(this.bankCode)) {
                this.bankName = "宁夏银行";
            } else if ("CQBANK".equals(this.bankCode)) {
                this.bankName = "重庆银行";
            } else if ("HRBANK".equals(this.bankCode)) {
                this.bankName = "哈尔滨银行";
            } else if ("LZYH".equals(this.bankCode)) {
                this.bankName = "兰州银行";
            } else if ("QDCCB".equals(this.bankCode)) {
                this.bankName = "青岛银行";
            } else if ("QHDCCB".equals(this.bankCode)) {
                this.bankName = "秦皇岛市商业银行";
            } else if ("BOQH".equals(this.bankCode)) {
                this.bankName = "青海银行";
            } else if ("TZCB".equals(this.bankCode)) {
                this.bankName = "台州银行";
            } else if ("CSCB".equals(this.bankCode)) {
                this.bankName = "长沙银行";
            } else if ("BOQZ".equals(this.bankCode)) {
                this.bankName = "泉州银行";
            } else if ("BSB".equals(this.bankCode)) {
                this.bankName = "包商银行";
            } else if ("DAQINGB".equals(this.bankCode)) {
                this.bankName = "龙江银行";
            } else if ("SHRCB".equals(this.bankCode)) {
                this.bankName = "上海农商银行";
            } else if ("ZJQL".equals(this.bankCode)) {
                this.bankName = "浙江泰隆商业银行";
            } else if ("H3CB".equals(this.bankCode)) {
                this.bankName = "内蒙古银行";
            } else if ("BGB".equals(this.bankCode)) {
                this.bankName = "广西北部湾银行";
            } else if ("GLBANK".equals(this.bankCode)) {
                this.bankName = "桂林银行";
            } else if ("DAQINGB".equals(this.bankCode)) {
                this.bankName = "龙江银行";
            } else if ("CDRCB".equals(this.bankCode)) {
                this.bankName = "成都农村商业银行";
            } else if ("FJNX".equals(this.bankCode)) {
                this.bankName = "福建省农村信用社联合社";
            } else if ("TRCB".equals(this.bankCode)) {
                this.bankName = "天津农村商业银行";
            } else if ("JSRCU".equals(this.bankCode)) {
                this.bankName = "江苏省农村信用社联合社";
            } else if ("SLH".equals(this.bankCode)) {
                this.bankName = "湖南农村信用社联合社";
            } else if ("JXNCX".equals(this.bankCode)) {
                this.bankName = "江西省农村信用社联合社";
            } else if ("SCBBANK".equals(this.bankCode)) {
                this.bankName = "商丘市商业银行";
            } else if ("HRXJB".equals(this.bankCode)) {
                this.bankName = "华融湘江银行";
            } else if ("HSBK".equals(this.bankCode)) {
                this.bankName = "衡水市商业银行";
            } else if ("CQNCSYCZ".equals(this.bankCode)) {
                this.bankName = "重庆南川石银村镇银行";
            } else if ("HNRCC".equals(this.bankCode)) {
                this.bankName = "湖南省农村信用社联合社";
            } else if ("XTB".equals(this.bankCode)) {
                this.bankName = "邢台银行";
            } else if ("LPRDNCXYS".equals(this.bankCode)) {
                this.bankName = "临汾市尧都区农村信用合作联社";
            } else if ("DYCCB".equals(this.bankCode)) {
                this.bankName = "东营银行";
            } else if ("SRBANK".equals(this.bankCode)) {
                this.bankName = "上饶银行";
            } else if ("DZBANK".equals(this.bankCode)) {
                this.bankName = "德州银行";
            } else if ("CDB".equals(this.bankCode)) {
                this.bankName = "承德银行";
            } else if ("YNRCC".equals(this.bankCode)) {
                this.bankName = "云南省农村信用社";
            } else if ("LZCCB".equals(this.bankCode)) {
                this.bankName = "柳州银行";
            } else if ("WHSYBANK".equals(this.bankCode)) {
                this.bankName = "威海市商业银行";
            } else if ("HZBANK".equals(this.bankCode)) {
                this.bankName = "湖州银行";
            } else if ("BANKWF".equals(this.bankCode)) {
                this.bankName = "潍坊银行";
            } else if ("GZB".equals(this.bankCode)) {
                this.bankName = "赣州银行";
            } else if ("RZGWYBANK".equals(this.bankCode)) {
                this.bankName = "日照银行";
            } else if ("NCB".equals(this.bankCode)) {
                this.bankName = "南昌银行";
            } else if ("GYCB".equals(this.bankCode)) {
                this.bankName = "贵阳银行";
            } else if ("BOJZ".equals(this.bankCode)) {
                this.bankName = "锦州银行";
            } else if ("QSBANK".equals(this.bankCode)) {
                this.bankName = "齐商银行";
            } else if ("RBOZ".equals(this.bankCode)) {
                this.bankName = "珠海华润银行";
            } else if ("HLDCCB".equals(this.bankCode)) {
                this.bankName = "葫芦岛市商业银行";
            } else if ("HBC".equals(this.bankCode)) {
                this.bankName = "宜昌市商业银行";
            } else if ("HZCB".equals(this.bankCode)) {
                this.bankName = "杭州商业银行";
            } else if ("JSBANK".equals(this.bankCode)) {
                this.bankName = "苏州市商业银行";
            } else if ("LYCB".equals(this.bankCode)) {
                this.bankName = "辽阳银行";
            } else if ("LYB".equals(this.bankCode)) {
                this.bankName = "洛阳银行";
            } else if ("JZCBANK".equals(this.bankCode)) {
                this.bankName = "焦作市商业银行";
            } else if ("ZJCCB".equals(this.bankCode)) {
                this.bankName = "镇江市商业银行";
            } else if ("FGXYBANK".equals(this.bankCode)) {
                this.bankName = "法国兴业银行";
            } else if ("DYBANK".equals(this.bankCode)) {
                this.bankName = "大华银行";
            } else if ("DIYEBANK".equals(this.bankCode)) {
                this.bankName = "企业银行";
            } else if ("HQBANK".equals(this.bankCode)) {
                this.bankName = "华侨银行";
            } else if ("HSB".equals(this.bankCode)) {
                this.bankName = "恒生银行";
            } else if ("LSB".equals(this.bankCode)) {
                this.bankName = "临沂商业银行";
            } else if ("YTCB".equals(this.bankCode)) {
                this.bankName = "烟台商业银行";
            } else if ("QLB".equals(this.bankCode)) {
                this.bankName = "齐鲁银行";
            } else if ("BCCC".equals(this.bankCode)) {
                this.bankName = "BC卡公司";
            } else if ("CYB".equals(this.bankCode)) {
                this.bankName = "集友银行";
            } else if ("TFB".equals(this.bankCode)) {
                this.bankName = "大丰银行";
            } else if ("AEON".equals(this.bankCode)) {
                this.bankName = "AEON信贷财务亚洲有限公司";
            } else if ("MABDA".equals(this.bankCode)) {
                this.bankName = "澳门BDA";
            }
        } else {
            throw new BusinessException(ConsumerErrorCode.E_140109);
        }

        return this.bankCode + "-" + this.bankName;
    }
}
