package com.${company!''}.${project!''}.model<#if module??>.${module}</#if>;

<#if containDecimal>
import java.math.BigDecimal;
import com.alibaba.fastjson.serializer.ToStringSerializer;
</#if>
<#if containDate>
import java.util.Date;
import com.alibaba.fastjson.annotation.JSONField;
</#if>
import javax.persistence.Table;
import com.smart.mvc.model.${extendsProject};

<#if tableComment??>
/**
 * ${tableComment}
 */
</#if>
@Table(name = "${tableName}")
public class ${model} extends ${extendsProject} {

	private static final long serialVersionUID = ${versionId}L;
	
	<#list fieldList as field>
		<#if field.description??>
	/** ${field.description} */
	  	</#if>
		<#if field.fieldType == "Date">
	@JSONField(format = "${field.format}")
	  	</#if>
		<#if field.fieldType == "BigDecimal">
	@JSONField(serializeUsing = ToStringSerializer.class)
	  	</#if>
	private ${field.fieldType} ${field.fieldName}<#if field.defaultValue??><#if field.fieldType == "Boolean"> = <#if field.defaultValue == "0">Boolean.FALSE<#else>Boolean.TRUE</#if><#elseif field.fieldType == "Integer"> = Integer.valueOf(${field.defaultValue})<#elseif field.fieldType == "Double"> = ${field.defaultValue}D<#else> = ${field.defaultValue}</#if></#if>;
	</#list>
	<#list fieldList as field>
	
	public ${field.fieldType} get${field.upperFieldName}() {
		return this.${field.fieldName};
	}
	
	public void set${field.upperFieldName}(${field.fieldType} ${field.fieldName}) {
		this.${field.fieldName} = ${field.fieldName};
	}
	</#list>
}
