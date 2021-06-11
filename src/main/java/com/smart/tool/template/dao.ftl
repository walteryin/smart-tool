package com.${company!''}.${project!''}.dao<#if module??>.${module}</#if>;

import com.${company!''}.${project!''}.model<#if module??>.${module}</#if>.${model};
import com.smart.core.dao.DynamicDao;

public interface ${model}Dao extends DynamicDao<${model}> {
}
