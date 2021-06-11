package com.${company!''}.${project!''}.service<#if module??>.${module}</#if>;
<#if containEnable>

import java.util.List;
</#if>

import com.${company!''}.${project!''}.model<#if module??>.${module}</#if>.${model};
import com.smart.core.service.BaseService;

public interface ${model}Service extends BaseService<${model}> {
<#if containEnable>

	void enable(Integer isEnable, List<Integer> idList);
</#if>
}