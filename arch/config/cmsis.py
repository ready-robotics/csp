def instantiateComponent(cmsisComponent):

	cmsisInformation = cmsisComponent.createCommentSymbol("cmsisInformation", None)

	import xml.etree.ElementTree as ET
	cmsisDescriptionFile = open(Variables.get("__CMSIS_PACK_DIR") + "/ARM.CMSIS.pdsc", "r")
	cmsisDescription = ET.fromstring(cmsisDescriptionFile.read())
	for release in cmsisDescription.iter("release"):
		cmsisInformation.setLabel("Release Information: " + str(release.attrib))
		break

	headerFileNames = ["cmsis_compiler.h", "cmsis_gcc.h", "tz_context.h", "arm_common_tables.h", "arm_const_structs.h", "arm_math.h"]

	for headerFileName in headerFileNames:
		headerFile = cmsisComponent.createFileSymbol(None, None)
		headerFile.setRelative(False)
		headerFile.setSourcePath(Variables.get("__CMSIS_PACK_DIR") + "/CMSIS/Include/" + headerFileName)
		headerFile.setOutputName(headerFileName)
		headerFile.setMarkup(False)
		headerFile.setOverwrite(True)
		headerFile.setDestPath("../../packs/CMSIS/CMSIS/Include/")
		headerFile.setProjectPath("packs/CMSIS/CMSIS/Include/")
		headerFile.setType("HEADER")
