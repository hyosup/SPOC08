sap.ui.define(["sap/ui/core/UIComponent","sap/ui/Device","com/mdpert/lgerppocfs1/model/models"],function(e,t,i){"use strict";return e.extend("com.mdpert.lgerppocfs1.Component",{metadata:{manifest:"json"},init:function(){e.prototype.init.apply(this,argume+
nts);this.getRouter().initialize();this.setModel(i.createDeviceModel(),"device")}})});                                                                                                                                                                         