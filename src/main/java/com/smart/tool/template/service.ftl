package com.${company!''}.${project!''}.service<#if module??>.${module}</#if>;
<#if containEnable>

import java.util.List;
</#if>

import com.${company!''}.${project!''}.model<#if module??>.${module}</#if>.${model};
import com.smart.mvc.service.Service;

public interface ${model}Service extends Service<${model}> {
<#if containEnable>

	/**
	 * 启用禁用操作
	 * @param isEnable 是否启用
	 * @param idList 管理员ID集合
	 * @return
	 */
	public void enable(Integer isEnable, List<Integer> idList);
</#if>
}