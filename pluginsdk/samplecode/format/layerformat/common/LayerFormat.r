// ADOBE SYSTEMS INCORPORATED
// Copyright  1993 - 2002 Adobe Systems Incorporated
// All Rights Reserved
//
// NOTICE:  Adobe permits you to use, modify, and distribute this 
// file in accordance with the terms of the Adobe license agreement
// accompanying it.  If you have received this file from a source
// other than Adobe, then your use, modification, or distribution
// of it requires the prior written permission of Adobe.
//-------------------------------------------------------------------
//-------------------------------------------------------------------------------
//
//	File:
//		LayerFormat.r
//
//	Description:
//		This file contains the resource definitions for the
//		File Format module LayerFormat, 
//		which writes a flat file with merged document pixels.
//
//	Use:
//		Format modules are called from the Save, Save as,
//		and Save a copy dialogs.
//
//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
//	Definitions -- Required by include files.
//-------------------------------------------------------------------------------

// The About box and resources are created in DialogUtilities.r.
// You can easily override them, if you like.

#define plugInName			"LayerFormat"
#define plugInCopyrightYear	"2015"
#define plugInDescription \
	"An example plug-in file format module for Adobe Photoshop�."

//-------------------------------------------------------------------------------
//	Definitions -- Required by other resources in this rez file.
//-------------------------------------------------------------------------------

// Dictionary (aete) resources:

#define vendorName			"AdobeSDK"
#define plugInAETEComment 	"layerformat example file format module"

#define plugInSuiteID		'sdK4'
#define plugInClassID		'simP'
#define plugInEventID		typeNull // must be this

//-------------------------------------------------------------------------------
//	Set up included files for Macintosh and Windows.
//-------------------------------------------------------------------------------

#include "PIDefines.h"
#include "PIResourceDefines.h"

#if __PIMac__
	#include "PIGeneral.r"
	#include "PIUtilities.r"
#elif defined(__PIWin__)
    #define Rez
	#include "PIGeneral.h"
	#include "PIUtilities.r"
#endif

#include "PITerminology.h"
#include "PIActions.h"

#include "LayerFormatTerminology.h"	// Terminology for plug-in.

//-------------------------------------------------------------------------------
//	PiPL resource
//-------------------------------------------------------------------------------

resource 'PiPL' (ResourceID, plugInName " PiPL", purgeable)
{
    {
		Kind { ImageFormat },
		Name { plugInName },
		Version { (latestFormatVersion << 16) | latestFormatSubVersion },

		Component { ComponentNumber, plugInName },

		#if Macintosh
			#if defined(__arm64__)
				CodeMacARM64 { "PluginMain" },
			#endif
			#if defined(__x86_64__)
				CodeMacIntel64 { "PluginMain" },
			#endif
		#elif MSWindows
			CodeEntryPointWin64 { "PluginMain" },
		#endif

		// This plug-in can read and write via POSIX I/O routines
		SupportsPOSIXIO {},

		// ClassID, eventID, aete ID, uniqueString:
		HasTerminology { plugInClassID, 
		                 plugInEventID, 
						 ResourceID, 
						 vendorName " " plugInName },
		
		SupportedModes
		{
			doesSupportBitmap, doesSupportGrayScale,
			doesSupportIndexedColor, doesSupportRGBColor,
			doesSupportCMYKColor, doesSupportHSLColor,
			doesSupportHSBColor, doesSupportMultichannel,
			doesSupportDuotone, doesSupportLABColor
		},
		
		// If you want your format module always enabled.	
		EnableInfo { "true" },

		// New for Photoshop 8, document sizes that are really big 
		// 32 bit row and columns, 2,000,000 current limit but we can handle more
		PlugInMaxSize { 2147483647, 2147483647 },

		// For older Photoshops that only support 30000 pixel documents, 
		// 16 bit row and columns
		FormatMaxSize { { 32767, 32767 } },

		FormatMaxChannels { {   1, 24, 24, 24, 24, 24, 
							   24, 24, 24, 24, 24, 24 } },
	
		FmtFileType { 'LYR ', '8BIM' },

		//ReadTypes { { '8B1F', '    ' } },

		FilteredTypes { { '8B1F', '    ' } },

		ReadExtensions { { 'LYR ' } },

		WriteExtensions { { 'LYR ' } },

		FilteredExtensions { { 'LYR ' } },

		FormatFlags { fmtSavesImageResources, 
		              fmtCanRead, 
					  fmtCanWrite, 
					  fmtCanWriteIfRead, 
					  fmtCanWriteTransparency, 
					  fmtCanCreateThumbnail},

		FormatICCFlags { iccCannotEmbedGray,
						 iccCanEmbedIndexed,
						 iccCannotEmbedRGB,
						 iccCanEmbedCMYK },

		FormatLayerSupport { doesSupportFormatLayers },

		// this is 4 gigabytes, Photoshop default is 2 gigabytes
		FormatFileSizeLimit { 4 }
		}
	};


//-------------------------------------------------------------------------------
//	Dictionary (scripting) resource
//-------------------------------------------------------------------------------

resource 'aete' (ResourceID, plugInName " dictionary", purgeable)
{
	1, 0, english, roman,									/* aete version and language specifiers */
	{
		vendorName,											/* vendor suite name */
		"Adobe example plug-ins",							/* optional description */
		plugInSuiteID,										/* suite ID */
		1,													/* suite code, must be 1 */
		1,													/* suite level, must be 1 */
		{},													/* structure for filters */
		{													/* non-filter plug-in class here */
			vendorName " layerFormat",						/* unique class name */
			plugInClassID,									/* class ID, must be unique or Suite ID */
			plugInAETEComment,								/* optional description */
			{												/* define inheritance */
				"<Inheritance>",							/* must be exactly this */
				keyInherits,								/* must be keyInherits */
				classFormat,								/* parent: Format, Import, Export */
				"parent class format",						/* optional description */
				flagsSingleProperty,						/* if properties, list below */
							
				"foo",
				keyMyFoo,
				typeBoolean,
				"foobar",
				flagsSingleProperty,
				
				"bar",
				keyMyBar,
				typeBoolean,
				"foobar",
				flagsSingleProperty
				/* no properties */
			},
			{}, /* elements (not supported) */
			/* class descriptions */
		},
		{}, /* comparison ops (not supported) */
		{}	/* any enumerations */
	}
};

//-------------------------------------------------------------------------------
//	History resource
//-------------------------------------------------------------------------------

resource StringResource (kHistoryEntry, "History", purgeable)
{
	plugInName ": ref num=^0."
};

//-------------------------------------------------------------------------------

// end LayerFormat.r
