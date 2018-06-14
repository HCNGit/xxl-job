$(function() {

	// init date tables
	var userTable = $("#user_list").dataTable({
		"deferRender": true,
		"processing" : true, 
	    "serverSide": true,
		"ajax": {
			url: base_url + "/usermanage/pageList",
			type:"post",
	        data : function ( d ) {
	        	var obj = {};
	        	obj.roleId = $('#roleId').val();
                obj.nameOrAccount = $('#nameOrAccount').val();
	        	obj.start = d.start;
	        	obj.length = d.length;
                return obj;
            }
	    },
	    "searching": false,
	    "ordering": false,
	    //"scrollX": true,	// scroll x，close self-adaption
	    "columns": [
	                {
	                	"data": null,
	                	"width":'10%',
	                	"render": function(data,type,row,meta){
	                		var content = '<input type= "checkbox" name= "groupCheck" userid ="'+row.id+'"/>';
	                		return content;
	                	}
	                },
	                {
	                	"data": 'name',
						"bSortable": false,
						"visible" : true,
						"width":'10%'
					},
	                {
	                	"data": 'account',
						"visible" : true,
						"width":'20%'
					},
	                { 
	                	"data": 'roleId',
						"width":'20%',
	                	"visible" : true,
	                	"render": function ( data, type, row ) {
	                		if ('1' == data) {
	                			return '<small class="label label-success" ><i class="fa fa-user"></i> 超级管理员</small>'; 
							} else if ('2' == data){
								return '<small class="label label-primary" ><i class="fa fa-user"></i> 管理员</small>';
							} else if ('3' == data){
								return '<small class="label label-warning" ><i class="fa fa-user-times"></i> 游客</small>';
							}
	                		return data;
	                	}
	                },
	                {
						"data": I18n.system_opt ,
						"width":'15%',
	                	"render": function ( data, type, row ) {
	                		return function(){

								// html
                                tableData['key'+row.id] = row;
								var html = '<p id="'+ row.id +'" >'+
									'<button class="btn btn-primary btn-xs resetPassword"  type="button">密码重置</button>  '+
									'<button class="btn btn-warning btn-xs update" type="button">修改</button>  '+
									'<button class="btn btn-danger btn-xs" _type="job_del" type="button">'+ I18n.system_opt_del +'</button>  '+
									'</p>';

	                			return html;
							};
	                	}
	                }
	            ],
		"language" : {
			"sProcessing" : I18n.dataTable_sProcessing ,
			"sLengthMenu" : I18n.dataTable_sLengthMenu ,
			"sZeroRecords" : I18n.dataTable_sZeroRecords ,
			"sInfo" : I18n.dataTable_sInfo ,
			"sInfoEmpty" : I18n.dataTable_sInfoEmpty ,
			"sInfoFiltered" : I18n.dataTable_sInfoFiltered ,
			"sInfoPostFix" : "",
			"sSearch" : I18n.dataTable_sSearch ,
			"sUrl" : "",
			"sEmptyTable" : I18n.dataTable_sEmptyTable ,
			"sLoadingRecords" : I18n.dataTable_sLoadingRecords ,
			"sInfoThousands" : ",",
			"oPaginate" : {
				"sFirst" : I18n.dataTable_sFirst ,
				"sPrevious" : I18n.dataTable_sPrevious ,
				"sNext" : I18n.dataTable_sNext ,
				"sLast" : I18n.dataTable_sLast
			},
			"oAria" : {
				"sSortAscending" : I18n.dataTable_sSortAscending ,
				"sSortDescending" : I18n.dataTable_sSortDescending
			}
		}
	});

    // table data
    var tableData = {};

	// search btn
	$('#searchBtn').on('click', function(){
		userTable.fnDraw();
	});
	
	//回车事件
	$('#nameOrAccount').bind('keypress',function(event){
		if(event.keyCode == "13"){
			userTable.fnDraw();
		}
	});
	
	//全选事件
	$('#allCheck').on('click',function(){
		if($('#allCheck').is(':checked') == true){
			$("Input[name = 'groupCheck']").each(function(){
				if($(this).is(':checked') == false){
					$(this).prop("checked",true);
				}
			})
		}
	});
	
	//反全选事件
	$('#allCheck').on('click',function(){
		if($('#allCheck').is(':checked') == false){
			$("Input[name = 'groupCheck']").each(function(){
				if($(this).is(':checked') == true){
					$(this).prop("checked",false);
				}
			})
		}
	});
	
	

	// add
	$(".add").click(function(){
		$('#addModal').modal({backdrop: false, keyboard: false}).modal('show');
	});
	var addModalValidate = $("#addModal .form").validate({
		errorElement : 'span',  
        errorClass : 'help-block',
        focusInvalid : true,
        rules : {
        	name : {
				required : true,
				rangelength:[1,10]
			},
            account : {
            	required : true,
            	rangelength:[5,16]
            }
        }, 
        messages : {  
        	name : {
            	required : I18n.system_please_input + "姓名",
            	rangelength: "姓名字段长度为1~10"
            },
            account : {
            	required : I18n.system_please_input + "帐号",
            	rangelength: "帐号字段长度为5~16"
            }
            
        },
		highlight : function(element) {  
            $(element).closest('.form-group').addClass('has-error');  
        },
        success : function(label) {  
            label.closest('.form-group').removeClass('has-error');  
            label.remove();  
        },
        errorPlacement : function(error, element) {  
            element.parent('div').append(error);  
        },
        submitHandler : function(form) {
        	$.post(base_url + "/usermanage/register",  $("#addModal .form").serialize(), function(data, status) {
    			if (data.code == "200") {
					$('#addModal').modal('hide');
					layer.open({
						title: I18n.system_tips ,
                        btn: [ I18n.system_ok ],
						content: I18n.system_add_suc ,
						icon: '1',
						end: function(layero, index){
							userTable.fnDraw();
							//window.location.reload();
						}
					});
    			} else {
					layer.open({
						title: I18n.system_tips ,
                        btn: [ I18n.system_ok ],
						content: (data.msg || I18n.system_add_fail),
						icon: '2'
					});
    			}
    		});
		}
	});
	$("#addModal").on('hide.bs.modal', function () {
		$("#addModal .form")[0].reset();
		addModalValidate.resetForm();
		$("#addModal .form .form-group").removeClass("has-error");
		$(".remote_panel").show();	// remote

		$("#addModal .form input[name='executorHandler']").removeAttr("readonly");
	});



	// update
	$("#user_list").on('click', '.update',function() {

        var id = $(this).parent('p').attr("id");
        var row = tableData['key'+id];

		// base data
		$("#updateModal .form input[name='id']").val( row.id );
		$('#updateModal .form select[name=roleId] option[value='+ row.roleId +']').prop('selected', true);
		$("#updateModal .form input[name='name']").val( row.name );
		$("#updateModal .form input[name='account']").val( row.account );

		// show
		$('#updateModal').modal({backdrop: false, keyboard: false}).modal('show');
	});
	var updateModalValidate = $("#updateModal .form").validate({
		errorElement : 'span',  
        errorClass : 'help-block',
        focusInvalid : true,
        rules : {
        	name : {
				required : true,
				rangelength:[1,10]
			},
            account : {
            	required : true,
            	rangelength:[5,16]
            }
        }, 
        messages : {  
        	name : {
            	required : I18n.system_please_input + "姓名",
            	rangelength: "姓名字段长度为1~10"
            },
            account : {
            	required : I18n.system_please_input + "帐号",
            	rangelength: "帐号字段长度为5~16"
            }
            
        },
		highlight : function(element) {
            $(element).closest('.form-group').addClass('has-error');  
        },
        success : function(label) {  
            label.closest('.form-group').removeClass('has-error');  
            label.remove();  
        },
        errorPlacement : function(error, element) {  
            element.parent('div').append(error);  
        },
        submitHandler : function(form) {
			// post
    		$.post(base_url + "/usermanage/update", $("#updateModal .form").serialize(), function(data, status) {
    			if (data.code == "200") {
					$('#updateModal').modal('hide');
					layer.open({
						title: I18n.system_tips ,
                        btn: [ I18n.system_ok ],
						content: I18n.system_update_suc ,
						icon: '1',
						end: function(layero, index){
							//window.location.reload();
							userTable.fnDraw();
						}
					});
    			} else {
					layer.open({
						title: I18n.system_tips ,
                        btn: [ I18n.system_ok ],
						content: (data.msg || I18n.system_update_fail ),
						icon: '2'
					});
    			}
    		});
		}
	});
	$("#updateModal").on('hide.bs.modal', function () {
		$("#updateModal .form")[0].reset()
	});

	//resetPassword
	$("#user_list").on('click', '.resetPassword',function() {
		
		var id = $(this).parent('p').attr("id");
		$.ajax({
			type:"POST",
			url:base_url + "/usermanage/resetPassword",
			data:{id:id},
			dataType:"json",
			success:function(data){
				if (data.code == "200") {
					layer.open({
						title: I18n.system_tips ,
                        btn: [ I18n.system_ok ],
						content: "密码重置成功" ,
						icon: '1',
						end: function(layero, index){
							//window.location.reload();
							userTable.fnDraw();
						}
					});
    			} else {
					layer.open({
						title: I18n.system_tips ,
                        btn: [ I18n.system_ok ],
						content: (data.msg || "密码重置失败" ),
						icon: '2'
					});
    			}
			}
		});
	});
	
    /**
	 * find title by name, GlueType
     
	function findGlueTypeTitle(glueType) {
		var glueTypeTitle;
        $("#addModal .form select[name=glueType] option").each(function () {
            var name = $(this).val();
            var title = $(this).text();
            if (glueType == name) {
                glueTypeTitle = title;
                return false
            }
        });
        return glueTypeTitle;
    }*/

});
