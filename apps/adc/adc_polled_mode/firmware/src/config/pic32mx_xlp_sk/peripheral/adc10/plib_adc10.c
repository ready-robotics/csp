/*******************************************************************************
  ADC Peripheral Library Interface Source File

  Company
    Microchip Technology Inc.

  File Name
    plib_adc10.c

  Summary
    ADC10 peripheral library source.

  Description
    This file implements the ADC peripheral library.

*******************************************************************************/

// DOM-IGNORE-BEGIN
/*******************************************************************************
* Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries.
*
* Subject to your compliance with these terms, you may use Microchip software
* and any derivatives exclusively with Microchip products. It is your
* responsibility to comply with third party license terms applicable to your
* use of third party software (including open source software) that may
* accompany Microchip software.
*
* THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER
* EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY IMPLIED
* WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A
* PARTICULAR PURPOSE.
*
* IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE,
* INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND
* WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP HAS
* BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO THE
* FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN
* ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF ANY,
* THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.
*******************************************************************************/
// DOM-IGNORE-END
#include "device.h"
#include "plib_adc10.h"

// *****************************************************************************
// *****************************************************************************
// Section: ADC10 Implementation
// *****************************************************************************
// *****************************************************************************


void ADC10_Initialize()
{
    AD1CON1CLR = _AD1CON1_ON_MASK;

    AD1CON1 = 0x40;
    AD1CHS = 0x70000;


    /* Turn ON ADC */
    AD1CON1SET = _AD1CON1_ON_MASK;
}

void ADC10_Enable()
{
    AD1CON1SET = _AD1CON1_ON_MASK;
}

void ADC10_Disable()
{
    AD1CON1CLR = _AD1CON1_ON_MASK;
}

void ADC10_SamplingStart(void)
{
    AD1CON1CLR = _AD1CON1_DONE_MASK;
    AD1CON1SET = _AD1CON1_SAMP_MASK;
}

void ADC10_ConversionStart()
{
    AD1CON1CLR = _AD1CON1_SAMP_MASK;
}

void ADC10_InputSelect(ADC10_MUX muxType, ADC10_INPUT_POSITIVE positiveInput, ADC10_INPUT_NEGATIVE negativeInput)
{
	if (muxType == ADC10_MUX_B)
	{
    	AD1CHSbits.CH0SB = positiveInput;
        AD1CHSbits.CH0NB = negativeInput;
	}
	else
	{
    	AD1CHSbits.CH0SA = positiveInput;
        AD1CHSbits.CH0NA = negativeInput;
	}
}

void ADC10_InputScanSelect(ADC10_INPUTS_SCAN *scanList, uint8_t numChannels)
{
    uint8_t channelNum;
    uint32_t ad1cssl = 0;
    for(channelNum = 0; channelNum < numChannels; channelNum++)
    {
        ad1cssl += scanList[channelNum];
    }
    AD1CSSL = ad1cssl;
}

/*Check if conversion result is available */
bool ADC10_ResultIsReady()
{
    return AD1CON1bits.DONE;
}

/* Read the conversion result */
uint32_t ADC10_ResultGet(ADC10_RESULT_BUFFER bufferNumber)
{
    return (*((&ADC1BUF0) + bufferNumber));
}
