
<#compress> <#-- To remove unwanted new lines -->

<#-- Create List of all the port pins for enum creation -->

<#assign PORTA_Pin_List = []>
<#assign PORTB_Pin_List = []>
<#assign PORTC_Pin_List = []>
<#assign PORTD_Pin_List = []>
<#assign PORTE_Pin_List = []>

<#list 1..PIO_PIN_TOTAL as i>
    <#assign pinport = "PIN_" + i + "_PIO_PIN">
    <#assign pinchannel = "PIN_" + i + "_PIO_CHANNEL">

    <#if .vars[pinport]?has_content>
        <#if .vars[pinchannel]?has_content>
            <#if .vars[pinchannel] == "A">
                <#assign PORTA_Pin_List = PORTA_Pin_List + [.vars[pinport]]>

            <#elseif .vars[pinchannel] == "B">
                <#assign PORTB_Pin_List = PORTB_Pin_List + [.vars[pinport]]>

            <#elseif .vars[pinchannel] == "C">
                <#assign PORTC_Pin_List = PORTC_Pin_List + [.vars[pinport]]>

            <#elseif .vars[pinchannel] == "D">
                <#assign PORTD_Pin_List = PORTD_Pin_List + [.vars[pinport]]>

            <#elseif .vars[pinchannel] == "E">
                <#assign PORTE_Pin_List = PORTE_Pin_List + [.vars[pinport]]>
            </#if>

        </#if>
    </#if>
</#list>

</#compress>
// *****************************************************************************
// *****************************************************************************
// Section: Data types and constants
// *****************************************************************************
// *****************************************************************************


// *****************************************************************************
/* Sys Port

  Summary:
    Identifies the available Port Channels.

  Description:
    This enumeration identifies the available Port Channels.

  Remarks:
    The caller should not rely on the specific numbers assigned to any of
    these values as they may change from one processor to the next.

    Not all ports are available on all devices.  Refer to the specific
    device data sheet to determine which ports are supported.
*/


typedef enum
{
    <#if PORTA_Pin_List?has_content>
    SYS_PORT_A = PIOA_BASE_ADDRESS,
    </#if>
    <#if PORTB_Pin_List?has_content>
    SYS_PORT_B = PIOB_BASE_ADDRESS,
    </#if>
    <#if PORTC_Pin_List?has_content>
    SYS_PORT_C = PIOC_BASE_ADDRESS,
    </#if>
    <#if PORTD_Pin_List?has_content>
    SYS_PORT_D = PIOD_BASE_ADDRESS,
    </#if>
    <#if PORTE_Pin_List?has_content>
    SYS_PORT_E = PIOE_BASE_ADDRESS
    </#if>
} SYS_PORT;


// *****************************************************************************
/* Sys Port Pins

  Summary:
    Identifies the available port pins.

  Description:
    This enumeration identifies the available port pins.

  Remarks:
    The caller should not rely on the specific numbers assigned to any of
    these values as they may change from one processor to the next.

    Not all pins are available on all devices.  Refer to the specific
    device data sheet to determine which pins are supported.
*/

typedef enum
{
    <#assign PORTA_Pin_List =  PORTA_Pin_List?sort>
    <#list PORTA_Pin_List as pin>
    SYS_PORT_PIN_PA${pin} = ${pin},
    </#list>
    <#assign PORTB_Pin_List =  PORTB_Pin_List?sort>
    <#list PORTB_Pin_List as pin>
    SYS_PORT_PIN_PB${pin} = ${pin+32},
    </#list>
    <#assign PORTC_Pin_List =  PORTC_Pin_List?sort>
    <#list PORTC_Pin_List as pin>
    SYS_PORT_PIN_PC${pin} = ${pin+64},
    </#list>
    <#assign PORTD_Pin_List =  PORTD_Pin_List?sort>
    <#list PORTD_Pin_List as pin>
    SYS_PORT_PIN_PD${pin} = ${pin+96},
    </#list>
    <#assign PORTE_Pin_List =  PORTE_Pin_List?sort>
    <#list PORTE_Pin_List as pin>
    SYS_PORT_PIN_PE${pin} = ${pin+128},
    </#list>
    /* This element should not be used in any of the PORTS APIs.
       It will be used by other modules or application to denote that none of the PORT Pin is used */
    SYS_PORT_PIN_NONE = -1
} SYS_PORT_PIN;
