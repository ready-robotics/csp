/*******************************************************************************
  AFEC Peripheral Library Interface Header File

  Company
    Microchip Technology Inc.

  File Name
    plib_${AFEC_INSTANCE_NAME?lower_case}.h

  Summary
    ${AFEC_INSTANCE_NAME} peripheral library interface.

  Description
    This file defines the interface to the AFEC peripheral library.  This
    library provides access to and control of the associated peripheral
    instance.

*******************************************************************************/

// DOM-IGNORE-BEGIN
/*******************************************************************************
Copyright (c) 2017 released Microchip Technology Inc.  All rights reserved.

Microchip licenses to you the right to use, modify, copy and distribute
Software only when embedded on a Microchip microcontroller or digital signal
controller that is integrated into your product or third party product
(pursuant to the sublicense terms in the accompanying license agreement).

You should refer to the license agreement accompanying this Software for
additional information regarding your rights and obligations.
SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF
MERCHANTABILITY, TITLE, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE.
IN NO EVENT SHALL MICROCHIP OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER
CONTRACT, NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR
OTHER LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE OR
CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT OF
SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
(INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.
*******************************************************************************/
// DOM-IGNORE-END

#ifndef PLIB_${AFEC_INSTANCE_NAME}_H    // Guards against multiple inclusion
#define PLIB_${AFEC_INSTANCE_NAME}_H


// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************

/*  This section lists the other files that are included in this file.
*/

#include "plib_afec_common.h"

// DOM-IGNORE-BEGIN
#ifdef __cplusplus  // Provide C++ Compatibility

extern "C" {

#endif

// DOM-IGNORE-END

// *****************************************************************************
// *****************************************************************************
// Section: Data Types
// *****************************************************************************
// *****************************************************************************
/*  The following data type definitions are used by the functions in this
    interface and should be considered part it.
*/
<#assign AFEC_INTERRUPT = false>
<#compress>
<#list 0..(AFEC_NUM_CHANNELS - 1) as i>
    <#assign AFEC_CH_ENABLE = "AFEC_"+i+"_CHER">
    <#assign AFEC_CH_NEG_INP = "AFEC_"+i+"_NEG_INP">
    <#assign AFEC_CH_NAME = "AFEC_"+i+"_NAME">
<#if i % 2 !=0 >
    <#assign AFEC_CH_DIFF_PAIR = "AFEC_"+(i-1)+"_NEG_INP">
</#if>
    <#assign CH_NUM = i>
    <#assign AFEC_CH_IER_EOC = "AFEC_"+i+"_IER_EOC">
<#if (.vars[AFEC_CH_ENABLE] == true) && (.vars[AFEC_CH_IER_EOC] == true)>
    <#assign AFEC_INTERRUPT = true>
</#if>

<#-- Find the max and min digital value based on the result resolution and single-ended/differential ended mode -->
<#if .vars[AFEC_CH_ENABLE] == true>
    <#if (i % 2 != 0) && (.vars[AFEC_CH_DIFF_PAIR] != "GND")>
    <#else>

        <#if .vars[AFEC_CH_NEG_INP] != "GND">
            <#if ((AFEC_EMR_SIGNMODE_VALUE == "ALL_UNSIGNED") || (AFEC_EMR_SIGNMODE_VALUE == "SE_SIGN_DF_UNSG")) >
                <#if (AFEC_EMR_RES_VALUE == "NO_AVERAGE")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (4095U)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (0U)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR4")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (8191U)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (0U)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR16")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (16383U)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (0U)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR64")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (32767U)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (0U)
                <#else>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (65535U)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (0U)
                </#if>
            </#if>
            <#if ((AFEC_EMR_SIGNMODE_VALUE == "ALL_SIGNED") || (AFEC_EMR_SIGNMODE_VALUE == "SE_UNSG_DF_SIGN")) >
                <#if (AFEC_EMR_RES_VALUE == "NO_AVERAGE")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (2047)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (-2048)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR4")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (4095)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (-4096)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR16")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (8191)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (-8192)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR64")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (16383)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (-16384)
                <#else>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (32767)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (-32768)
                </#if>
            </#if>
        <#else>
            <#if ((AFEC_EMR_SIGNMODE_VALUE == "ALL_UNSIGNED") || (AFEC_EMR_SIGNMODE_VALUE == "SE_UNSG_DF_SIGN")) >
                <#if (AFEC_EMR_RES_VALUE == "NO_AVERAGE")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (4095U)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (0U)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR4")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (8191U)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (0U)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR16")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (16383U)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (0U)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR64")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (32767U)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (0U)
                <#else>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (65535U)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (0U)
                </#if>
            </#if>
            <#if ((AFEC_EMR_SIGNMODE_VALUE == "ALL_SIGNED") || (AFEC_EMR_SIGNMODE_VALUE == "SE_SIGN_DF_UNSG")) >
                <#if (AFEC_EMR_RES_VALUE == "NO_AVERAGE")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (2047)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (-2048)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR4")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (4095)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (-4096)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR16")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (8191)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (-8192)
                <#elseif (AFEC_EMR_RES_VALUE == "OSR64")>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (16383)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (-16384)
                <#else>
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MAX_OUTPUT  (32767)
                    #define ${AFEC_INSTANCE_NAME}_CH${CH_NUM}_MIN_OUTPUT  (-32768)
                </#if>
            </#if>
        </#if>

#define ${.vars[AFEC_CH_NAME]} (${CH_NUM}U)
/***********************************************************************/
    </#if>
</#if> <#-- CH ENABLE -->
</#list>
</#compress>


// *****************************************************************************
// *****************************************************************************
// Section: Interface Routines
// *****************************************************************************
// *****************************************************************************
/* The following functions make up the methods (set of possible operations) of
   this interface.
*/

void ${AFEC_INSTANCE_NAME}_Initialize (void);

void ${AFEC_INSTANCE_NAME}_ChannelsEnable (AFEC_CHANNEL_MASK channelsMask);

void ${AFEC_INSTANCE_NAME}_ChannelsDisable (AFEC_CHANNEL_MASK channelsMask);

void ${AFEC_INSTANCE_NAME}_ChannelsInterruptEnable (AFEC_INTERRUPT_MASK channelsInterruptMask);

void ${AFEC_INSTANCE_NAME}_ChannelsInterruptDisable (AFEC_INTERRUPT_MASK channelsInterruptMask);

void ${AFEC_INSTANCE_NAME}_ConversionStart(void);

bool ${AFEC_INSTANCE_NAME}_ChannelResultIsReady(AFEC_CHANNEL_NUM channel);

uint16_t ${AFEC_INSTANCE_NAME}_ChannelResultGet(AFEC_CHANNEL_NUM channel);

void ${AFEC_INSTANCE_NAME}_ConversionSequenceSet(AFEC_CHANNEL_NUM *channelList, uint8_t numChannel);

void ${AFEC_INSTANCE_NAME}_ChannelGainSet(AFEC_CHANNEL_NUM channel, AFEC_CHANNEL_GAIN gain);

void ${AFEC_INSTANCE_NAME}_ChannelOffsetSet(AFEC_CHANNEL_NUM channel, uint16_t offset);

<#if AFEC_INTERRUPT == true>
    <#lt>void ${AFEC_INSTANCE_NAME}_CallbackRegister(AFEC_CALLBACK callback, uintptr_t context);
</#if>
// *****************************************************************************

// DOM-IGNORE-BEGIN
#ifdef __cplusplus  // Provide C++ Compatibility

}

#endif
// DOM-IGNORE-END

#endif //PLIB_${AFEC_INSTANCE_NAME}_H

/**
 End of File
*/

