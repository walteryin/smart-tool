<title>${tableComment!''}-_&{_systemName}</title>
<_@include "../common/common.html"/>

<div class="page-header">
	<h1>
		_&{${_model!''}.id?? ? string('修改','添加')}${tableComment!''}
	</h1>
</div>

<div class="row">
	<div class="col-xs-12">
		<form id="_editForm" class="form-horizontal" role="form"
			validate="true">
			<input type="hidden" name="id" value="_&{${_model!''}.id!}"> 
			
			<#list fieldList as field>
		        <#if field.fieldName == enableName>
			<div class="form-group">
				<label class="control-label col-xs-12 col-sm-3 no-padding-right"><span class="form-star">*</span>${field.description!''}</label>

				<div class="col-xs-12 col-sm-9">
					<div class="clearfix help-validate">
						<div>
							<label class="line-height-1 blue">
								<input name="${field.fieldName!''}" value="1" type="radio" class="ace" <_@if ${_model!''}.${field.fieldName!''}?? && ${_model!''}.${field.fieldName!''} == 1>checked="checked"</_@if>/>
								<span class="lbl"> 是</span>
							</label>
						</div>
	
						<div>
							<label class="line-height-1 blue">
								<input name="${field.fieldName!''}" value="0" type="radio" class="ace" <_@if !(${_model!''}.${field.fieldName!''}??) || ${_model!''}.${field.fieldName!''} == 0>checked="checked"</_@if>/>
								<span class="lbl"> 否</span>
							</label>
						</div>
					</div>
				</div>
			</div>

				<#elseif field.fieldType == "Date">
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="_${field.fieldName!''}"><#if field.nullableStr == "false"><span class="form-star">*</span></#if>${field.description!''}</label>

				<div class="col-sm-9">
					<div class="input-medium help-validate">
						<div class="input-group">
							<input id="_${field.fieldName!''}" name="${field.fieldName!''}" type="text" value="_&{(${_model!''}.${field.fieldName!''} ? string("${field.format!''}"))!}" class="input-medium" placeholder="${field.description!''}"
								<#if field.nullableStr == "false">required="true"</#if>/>
							<span class="input-group-addon">
								<i class="ace-icon fa fa-calendar"></i>
							</span>
						</div>
					</div>
				</div>
			</div>

				<#elseif field.fieldType == "Integer">
			<div class="form-group">
				<label for="_${field.fieldName!''}" class="col-sm-3 control-label no-padding-right"><#if field.nullableStr == "false"><span class="form-star">*</span></#if>${field.description!''}</label>

				<div class="col-sm-9">
					<div class="clearfix help-validate">
						<input id="_${field.fieldName!''}" name="${field.fieldName!''}" type="text" value="_&{${_model!''}.${field.fieldName!''}!}" class="form-data col-xs-10 col-sm-5" placeholder="${field.description!''}"
							<#if field.nullableStr == "false">required="true"</#if> vtype="integer"<#if field.intMaxLengthStr??> maxlength="${field.intMaxLengthStr}"</#if>/>
					</div>
				</div>
			</div>

				<#elseif field.fieldType == "Double" || field.fieldType == "BigDecimal">
			<div class="form-group">
				<label for="_${field.fieldName!''}" class="col-sm-3 control-label no-padding-right"><#if field.nullableStr == "false"><span class="form-star">*</span></#if>${field.description!''}</label>

				<div class="col-sm-9">
					<div class="clearfix help-validate">
						<input id="_${field.fieldName!''}" name="${field.fieldName!''}" type="text" value="_&{${_model!''}.${field.fieldName!''}!}" class="form-data col-xs-10 col-sm-5" placeholder="${field.description!''}"
							<#if field.nullableStr == "false">required="true"</#if> vtype="double"<#if field.maxLengthStr??> maxlength="${field.maxLengthStr}"</#if>/>
					</div>
				</div>
			</div>

				<#else>
			<div class="form-group">
				<label for="_${field.fieldName!''}" class="col-sm-3 control-label no-padding-right"><#if field.nullableStr == "false"><span class="form-star">*</span></#if>${field.description!''}</label>

				<div class="col-sm-9">
					<div class="clearfix help-validate">
						<input id="_${field.fieldName!''}" name="${field.fieldName!''}" type="text" value="_&{${_model!''}.${field.fieldName!''}!}" class="form-data col-xs-10 col-sm-5" placeholder="${field.description!''}"
							<#if field.nullableStr == "false">required="true"</#if> <#if field.maxLengthStr??> maxlength="${field.maxLengthStr}"</#if>/>
					</div>
				</div>
			</div>

				</#if>
			</#list>
			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button id="_submit" type="button" class="btn btn-info" data-loading-text="正在提交..." permission="/admin/${mapping!''}/save">
						<i class="ace-icon fa fa-check bigger-110"></i>
						提交
					</button>

					&nbsp; &nbsp; &nbsp;
					<button id="_cancle" class="btn" type="reset">
						<i class="ace-icon fa  fa-times bigger-110"></i>
						取消
					</button>
				</div>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
		jQuery(function(_&) {
			// 提交
			_&("#_submit").click(function(){
				if(_&('#_editForm').validate()){
					var btn = _&(this);
					btn.button('loading');
					_&.post("${path}/admin/${mapping!''}/save", _&.formJson('_editForm'),function(d) {
						if(d){
							btn.button('reset');
							if(d.code == 1){
								$.aceRedirect("${path}/admin/${mapping!''}");
							}
							else {
								$.gritter.add({text: d.message});
							}
						}
					},'json');
				}
			});
			<#list fieldList as field>
		        <#if field.fieldType == "Date">

			// 日期+时间
			_&('#_${field.fieldName!''}').daterangepicker({
				singleDatePicker: true,
				'applyClass' : 'btn btn-info',
				'cancelClass' : 'btn',
				locale: {
					applyLabel: '确定',
					cancelLabel: '取消',
					fromLabel: '自',
	                toLabel: '至'
				},
				timePicker: true,
				format: 'YYYY-MM-DD HH:mm:ss'
			}, function(start, end, label) {
                _&('#_${field.fieldName!''}').validate();
            });
            	</#if>
			</#list>
			
			// 取消
			_&("#_cancle").click(function(){
				$.aceRedirect("${path}/admin/${mapping!''}");
			});
			
			// 回车绑定
			_&(".form-data").bind('keypress',function(event){
				if(event.keyCode == "13"){
                	event.preventDefault();
                	_&("#_submit").click();
				}
			});
            
			// 权限处理
			_&.permission();
		});
	});
</script>



