package com.wanxin.uaa.config;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;
import org.springframework.web.util.HtmlUtils;

import java.io.IOException;
import java.util.Map;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class RestOAuthExceptionJacksonSerializer extends StdSerializer<RestOAuth2Exception> {

    protected RestOAuthExceptionJacksonSerializer() {
        super(RestOAuth2Exception.class);
    }

    @Override
    public void serialize(RestOAuth2Exception value, JsonGenerator jgen, SerializerProvider serializerProvider) throws IOException {
        jgen.writeStartObject();
        jgen.writeObjectField("code", value.getHttpErrorCode());
        String errorMessage = value.getOAuth2ErrorCode();
        if (errorMessage != null) {
            errorMessage = HtmlUtils.htmlEscape(errorMessage);
        }
        jgen.writeStringField("msg", value.getMessage());
        String summary = value.getSummary();
        jgen.writeStringField("result", summary);

        if (value.getAdditionalInformation() != null) {
            for (Map.Entry<String, String> entry : value.getAdditionalInformation().entrySet()) {
                String key = entry.getKey();
                String add = entry.getValue();
                jgen.writeStringField(key, add);
            }
        }
        jgen.writeEndObject();
    }
}
