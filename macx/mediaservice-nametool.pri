# Media service plugins
MEDIASERVICEPLUGIN_DIR  = $$(QTDIR)/plugins/mediaservice
mediaservice.path = $$INSTALLROOT/PlugIns/mediaservice

FLAVORS = qavfmediaplayer
for(i, FLAVORS):{
    FILE = lib$${i}.dylib
    mediaservice.files += $$MEDIASERVICEPLUGIN_DIR/$$FILE
    qtnametool.commands += && $$LIBQTCORE_INSTALL_NAME_TOOL $$INSTALLROOT/PlugIns/mediaservice/$$FILE
    qtnametool.commands += && $$LIBQTGUI_INSTALL_NAME_TOOL $$INSTALLROOT/PlugIns/mediaservice/$$FILE
    qtnametool.commands += && $$LIBQTWIDGETS_INSTALL_NAME_TOOL $$INSTALLROOT/PlugIns/mediaservice/$$FILE
    qtnametool.commands += && $$LIBQTPRINTSUPPORT_INSTALL_NAME_TOOL $$INSTALLROOT/PlugIns/mediaservice/$$FILE
    qtnametool.commands += && install_name_tool -id @executable_path/../PlugIns/mediaservice/$$FILE $$INSTALLROOT/PlugIns/mediaservice/$$FILE

    !isEmpty(nametool.commands) {
        nametool.commands += "&&"
    }

    nametool.commands += install_name_tool -change $$(QTDIR)/plugins/mediaservice/$$FILE \
                @executable_path/../PlugIns/mediaservice/$$FILE $$OUTFILE
}
