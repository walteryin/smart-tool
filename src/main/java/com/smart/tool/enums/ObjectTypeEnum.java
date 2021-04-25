package com.smart.tool.enums;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * 对象类型
 * 
 * @author Joe
 */
public enum ObjectTypeEnum {
	PERSISTENT_OBJECT("PersistentObject", "BaseServiceImpl", new String[] { "id" }), 
	DELETE_FLAG_PERSISTENT_OBJECT("DeleteFlagPersistentObject", "DeleteFlagServiceImpl", new String[] { "id", "deleteFlag" });

	private Object name;
	private String serviceImplName;
	private String[] fields;

	private ObjectTypeEnum(Object name, String serviceImplName, String[] fields) {
		this.name = name;
		this.serviceImplName = serviceImplName;
		this.fields = fields;
	}

	public Object getName() {
		return name;
	}

	public String getServiceImplName() {
		return serviceImplName;
	}

	public String[] getFields() {
		return fields;
	}
	
	public static List<Object> getNameList() {
		return Stream.of(ObjectTypeEnum.class.getEnumConstants()).map(a->a.getName()).collect(Collectors.toList());
	}
	
	public static String[] getFields(Object name) {
		return Optional.ofNullable(Stream.of(ObjectTypeEnum.class.getEnumConstants())
				.filter(a -> a.getName().equals(name)).findAny().orElse(null)).map(d -> d.getFields()).orElse(null);
	}

	public static String getServiceImplName(Object name) {
		return Optional.ofNullable(Stream.of(ObjectTypeEnum.class.getEnumConstants())
				.filter(a -> a.getName().equals(name)).findAny().orElse(null)).map(d -> d.getServiceImplName())
				.orElse(null);
	}
}