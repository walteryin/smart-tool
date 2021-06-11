package com.${company!''}.${project!''}.service.impl<#if module??>.${module}</#if>;
<#if containEnable>

import java.util.List;
import org.springframework.transaction.annotation.Transactional;
</#if>

import org.springframework.stereotype.Component;

import com.${company!''}.${project!''}.model<#if module??>.${module}</#if>.${model};
import com.${company!''}.${project!''}.dao<#if module??>.${module}</#if>.${model}Dao;
import com.${company!''}.${project!''}.service<#if module??>.${module}</#if>.${model}Service;
import com.smart.core.service.impl.${serviceImplName};

@Component("${_model}Service")
public class ${model}ServiceImpl extends ${serviceImplName}<${model}Dao, ${model}> implements ${model}Service {
<#if containEnable>

	@Transactional
	@Override
	public void enable(Integer isEnable, List<Integer> idList) {
		selectByIds(idList).forEach(t -> {
            t.setIsEnable(isEnable);
            update(t);
        });
	}
</#if>
}
