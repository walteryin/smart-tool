package com.${company!''}.${project!''}.controller<#if admin??>.${admin}</#if><#if module??>.${module}</#if>;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

<#if containDecimal>
import java.math.BigDecimal;
</#if>
<#if containDate>
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
</#if>
import org.springframework.stereotype.Controller;
<#if containWeb>
import org.springframework.ui.Model;
</#if>
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.${company!''}.${project!''}.model<#if module??>.${module}</#if>.${model};
import com.${company!''}.${project!''}.service<#if module??>.${module}</#if>.${model}Service;
import com.smart.core.controller.BaseController;
import com.smart.core.model.Result;
import com.smart.core.model.Page;
import com.smart.core.validator.Validator;
import com.smart.core.validator.annotation.ValidateParam;

@Api(tags = "${tableComment}")
@Controller
@RequestMapping("<#if admin??>/${admin}</#if><#if module??>/${module}</#if>/${_model}")
@SuppressWarnings("rawtypes")
public class ${model}Controller extends BaseController {

	@Autowired
	private ${model}Service ${_model}Service;
<#if containWeb>

	@ApiOperation("入口页")
	@RequestMapping(method = RequestMethod.GET)
	public String execute() {
		return "<#if admin??>/${admin}</#if><#if module??>/${module}</#if>/${mapping}";
	}
</#if>
	
	@ApiOperation("列表")
	@ResponseBody
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public Result list(
			@ValidateParam(name = "开始页码", defaultValue = DEFAULT_PAGE_NO) Integer pageNo,
			@ValidateParam(name = "显示条数", defaultValue = DEFAULT_PAGE_SIZE) Integer pageSize) {
		return Result.createSuccess(${_model}Service.selectPage(Page.create(pageNo, pageSize)));
	}
<#if containWeb>

	@ApiOperation("编辑页")
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(@ValidateParam(name = "id") Integer id, Model model) {
		${model} ${_model};
		if (id == null) {
			${_model} = new ${model}();
		}
		else {
			${_model} = ${_model}Service.get(id);
		}
		model.addAttribute("${_model}", ${_model});
		return "<#if admin??>/${admin}</#if><#if module??>/${module}</#if>/${mapping}_edit";
	}
</#if>
	
	@ApiOperation("获取")
	@ResponseBody
	@RequestMapping(value = "/get", method = RequestMethod.GET)
    public Result get(@ValidateParam(name = "id", value = {Validator.NOT_BLANK}) Integer id) {
	    return Result.createSuccess(${_model}Service.get(id));
    }

	@ApiOperation("保存")
	@ResponseBody
	@RequestMapping(value = "/save")
	public Result save(
			@ValidateParam(name = "id") Integer id,
		<#list fieldList as field>
			@ValidateParam(<#if field.description??>name = "${field.description}"</#if><#if field.nullableStr == "false">, value = { Validator.NOT_BLANK }</#if>)<#if field.fieldType == "Date"> @DateTimeFormat(pattern = "${field.format}") Date<#else> ${field.fieldType}</#if> ${field.fieldName}<#if field_has_next>,</#if>
		</#list>
			) {
		${model} ${_model};
		if (id == null) {
			${_model} = new ${model}();
		}
		else {
			${_model} = ${_model}Service.get(id);
		}
		<#list fieldList as field>
		${_model}.set${field.upperFieldName}(${field.fieldName});
		</#list>
		${_model}Service.save(${_model});
		return Result.success();
	}
<#if containEnable>

	@ApiOperation("启用/禁用")
	@ResponseBody
	@RequestMapping(value = "/enable", method = RequestMethod.POST)
	public Result enable(
			@ValidateParam(name = "ids", value = { Validator.NOT_BLANK }) String ids,
			@ValidateParam(name = "是否启用", value = { Validator.NOT_BLANK }) Integer isEnable) {
		${_model}Service.enable(isEnable, convertToIdList(ids));
		return Result.success();
	}
</#if>

	@ApiOperation("删除")
	@ResponseBody
	@RequestMapping(value = "/delete")
	public Result delete(
			@ValidateParam(name = "ids", value = { Validator.NOT_BLANK }) String ids) {
		${_model}Service.deleteByIds(convertToIdList(ids));
		return Result.success();
	}
}