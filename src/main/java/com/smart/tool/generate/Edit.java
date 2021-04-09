package com.smart.tool.generate;

import java.util.HashMap;
import java.util.Map;

import com.smart.tool.system.DummyField;
import com.smart.tool.system.FreemarkerUtils;
import com.smart.tool.system.Generator;

/**
 * 编辑页
 * 
 * @author Joe
 */
public class Edit {

	private Map<String, Object> dataMap;

	public Edit(String tableComment, String model, String mapping, boolean containEnable, String enableName,
			java.util.List<DummyField> fieldList) {
		dataMap = new HashMap<>();
		/** 公司 **/
		dataMap.put("path", "${_path}");
		/** 项目 **/
		dataMap.put("systemName", "${_systemName}");
		/** 表描述 **/
		dataMap.put("tableComment", tableComment);
		/** 小写开头模型 **/
		dataMap.put("_model", Generator.getLowerStr(model));
		/** 映射 **/
		dataMap.put("mapping", mapping);
		/** 是否包含启用 **/
		dataMap.put("containEnable", containEnable);
		/** 是否启用名称 **/
		dataMap.put("enableName", enableName);
		/** 字段list **/
		dataMap.put("fieldList", fieldList);
	}
	
	public String getHtml(){
		return FreemarkerUtils.getText("edit.ftl", dataMap).replace("_&", "$").replaceAll("_@", "#");
	}
}
