<!DOCTYPE html>
<html>
<head>
  	<#import "/common/common.macro.ftl" as netCommon>
	<@netCommon.commonStyle />
	<!-- DataTables -->
  	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/plugins/datatables/dataTables.bootstrap.css">
    <title>${I18n.admin_name}</title>
</head>
<body class="hold-transition skin-blue sidebar-mini <#if cookieMap?exists && "off" == cookieMap["xxljob_adminlte_settings"].value >sidebar-collapse</#if> ">
<div class="wrapper">
	<!-- header -->
	<@netCommon.commonHeader />
	<!-- left -->
	<@netCommon.commonLeft "usermanage" />
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<section class="content-header">
			<h1>人员管理</h1>
		</section>

		<!-- Main content -->
	    <section class="content">
			
			<div class="row">
			    <div class="col-xs-1"></div>
			    <div class="col-xs-3">
                    <div class="input-group">
                        <span class="input-group-addon">角色</span>
                        <select class="form-control" id="roleId">
                            <option value="0" >全部</option>
                            <option value="1" >超级管理员</option>
                            <option value="2" >管理员</option>
                            <option value="3" >游客</option>
                        </select>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="input-group">
                        <span class="input-group-addon">姓名/帐号</span>
                        <input type="text" class="form-control" id="nameOrAccount" >
                    </div>
                </div>
				<div class="col-xs-1">
                    <button class="btn btn-block btn-info" id="searchBtn">${I18n.system_search}</button>
                </div>
                <div class="col-xs-2">
                    <button class="btn btn-block btn-success add" type="button">新增用户</button>
                </div>
                <div class="col-xs-2">
                    <button class="btn btn-block btn-danger add" type="button">批量删除</button>
                </div>
			</div>
			
			<div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header hide">
                            <h3 class="box-title">人员列表</h3>
                        </div>
                        <div class="box-body" >
                            <table id="user_list" class="table table-bordered table-striped" width="100%" >
                                <thead>
                                    <tr>
                                        <th><input type="checkbox" id="allCheck"/></th>
                                        <th>姓名</th>
                                        <th>帐号</th>
                                        <th>角色</th>
                                        <th>${I18n.system_opt}</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                                <tfoot></tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
	    </section>
	</div>

    <!-- 新增.模态框 -->
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog"  aria-hidden="true">
        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" >添加人员</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal form" role="form" >
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">姓名<font color="red">*</font></label>
                            <div class="col-sm-6"><input type="text" class="form-control" name="name" placeholder="${I18n.system_please_input}姓名" maxlength="64" ></div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">帐号<font color="red">*</font></label>
                            <div class="col-sm-6"><input type="text" class="form-control" name="account" placeholder="${I18n.system_please_input}帐号" maxlength="32" ></div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">角色<font color="red">*</font></label>
                            <div class="col-sm-6">
                            <select class="form-control" name="roleId">
                                <option value="1" >超级管理员</option>
                                <option value="2" >管理员</option>
                                <option value="3" >游客</option>
                            </select>
                            </div>
                        </div>
                        
                        <hr>
                        <div class="form-group" style="text-align:center">
                            <div class="col-sm-offset-3 col-sm-6">
                                <button type="submit" class="btn btn-primary"  >${I18n.system_ok}</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">${I18n.system_cancel}</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- 更新.模态框 -->
    <div class="modal fade" id="updateModal" tabindex="-1" role="dialog"  aria-hidden="true">
        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" >更改信息</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal form" role="form" >
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">姓名<font color="red">*</font></label>
                            <div class="col-sm-6"><input type="text" class="form-control" name="name" maxlength="64" ></div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">帐号<font color="red">*</font></label>
                            <div class="col-sm-6"><input type="text" class="form-control" name="account" maxlength="32" ></div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">角色<font color="red">*</font></label>
                            <div class="col-sm-6">
                            <select class="form-control" name="roleId">
                                <option value="1" >超级管理员</option>
                                <option value="2" >管理员</option>
                                <option value="3" >游客</option>
                            </select>
                            </div>
                        </div>
                        
                        <hr>
                        <div class="form-group" style="text-align:center">
                            <div class="col-sm-offset-3 col-sm-6">
                                <button type="submit" class="btn btn-primary"  >${I18n.system_save}</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">${I18n.system_cancel}</button>
                                <input type="hidden" name="id" >
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
	
	<!-- footer -->
	<@netCommon.commonFooter />
</div>

<@netCommon.commonScript />
<!-- DataTables -->
<script src="${request.contextPath}/static/adminlte/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${request.contextPath}/static/adminlte/plugins/datatables/dataTables.bootstrap.min.js"></script>
<#-- jquery.validate -->
<script src="${request.contextPath}/static/plugins/jquery/jquery.validate.min.js"></script>
<script src="${request.contextPath}/static/js/usermanage.index.1.js"></script>
</body>
</html>
