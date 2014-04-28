//======================================================================
// Title        : STM32F4xx Register Definitions
// Authors      : Anton Rieckert
// Email        : anton@riecktron.co.za
// Last Updated : March, 2014
// Updates      : www.riecktron.co.za
//
// Copyright (c) 2013-2014 Anton Rieckert (anton@riecktron.co.za)
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files
// (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//======================================================================
unit stm32f0xx;

{$goto on}
{$define stm32f0xx}

//======================================================================
interface

{$PACKRECORDS 4}

//======================================================================
// Peripheral base offsets
//======================================================================
const
  PeripheralBase      = $40000000;

  // Peripheral memory map
  APBBase               = PeripheralBase;
  AHB1Base              = (PeripheralBase + $00020000);
  AHB2Base              = (PeripheralBase + $08000000);

//======================================================================
// RCC register type definitions
//======================================================================
type
  TRCCRegisters = record
    CR          : longword;
    CFGR        : longword;
    CIR         : longword;
    APB2RSTR    : longword;
    APB1RSTR    : longword;
    AHBENR      : longword;
    APB2ENR     : longword;
    APB1ENR     : longword;
    BDCR        : longword;
    CSR         : longword;
    AHBRSTR     : longword;
    CFGR2       : longword;
    CFGR3       : longword;
    CR2         : longword;
end;

//======================================================================
// PORT register type definitions
//======================================================================
type
  TPortRegisters = record
    MODER : dword;
    OTYPER : word;
    RESERVED0 : word;
    OSPEEDR : dword;
    PUPDR : dword;
    IDR : word;
    RESERVED1 : word;
    ODR : word;
    RESERVED2 : word;
    BSRR : dword;
    LCKR : dword;
    AFR : array[0..1] of dword;
    BRR : word;
    RESERVED3 : word;
  end;

//======================================================================
// USRAT register type definitions
//======================================================================
type
  TUSARTRegisters = record
    SR, res1   : word;        // 0x00
    DR, res2   : word;        // 0x04
    BRR, res3  : word;        // 0x08
    CR1, res4  : word;        // 0x0C
    CR2, res5  : word;        // 0x10
    CR3, res6  : word;        // 0x14
    GTPR, res7 : word;        // 0x18
  end;

//======================================================================
// SPI register type definitions
//======================================================================
type
  TSPIRegisters = record
    CR1, res1     : word;     //0x00
    CR2, res2     : word;     //0x04
    SR, res3      : word;     //0x08
    DR, res4      : word;     //0x0C
    CRCPR, res5   : word;     //0x10
    RXCRCR, res6  : word;     //0x14
    TXCRCR, res7  : word;     //0x18
    I2SCFGR, res8 : word;     //0x1C
    I2SPR, res9   : word;     //0x20
  end;

//======================================================================
// I2C register type definitions
//======================================================================
type
  TI2CRegisters = record
    CR1         : longword;   //0x00
    CR2         : longword;   //0x04
    OAR1, res1  : word;       //0x08
    OAR2, res2  : word;       //0x0C
    TIMINGR     : longword;   //0x10
    TIMEOUTR    : longword;   //0x14
    ISR         : longword;   //0x18
    ICR, res3   : word;       //0x1C
    PECR, res4  : word;       //0x20
    RXDR, res5  : word;       //0x24
    TXDR, res6  : word;       //0x28
  end;

//======================================================================
// FLASH register type definitions
//======================================================================
type
  TFlashRegisters = record
    ACR     : longword;       //0x00
    KEYR    : longword;       //0x04
    OPTKEYR : longword;       //0x08
    SR      : longword;       //0x0C
    CR      : longword;       //0x10
    OPTCR   : longword;       //0x14
  end;

//======================================================================
// FSMC control register type definitions
//======================================================================
type
  TFSMC = record
    BCR1  : longword;         // 0x0000    \
    BTR1  : longword;         // 0x0004     |
    BCR2  : longword;         // 0x0008     |
    BTR2  : longword;         // 0x000C     |
    BCR3  : longword;         // 0x0010     | Bank 1
    BTR3  : longword;         // 0x0014     |
    BCR4  : longword;         // 0x0018     |
    BTR4  : longword;         // 0x001C    /

    res0  : array [0..16] of longword;  // 0x0020 - 0x005C

    PCR2  : longword;         // 0x0060    \
    SR2   : longword;         // 0x0064     |
    PMEM2 : longword;         // 0x0068     |
    PATT2 : longword;         // 0x006C     | Bank 2
    res1  : longword;         // 0x0070     |
    ECCR2 : longword;         // 0x0074    /

    res2  : array [0..1] of longword;   // 0x0078 - 0x007C

    PCR3  : longword;         // 0x0080    \
    SR3   : longword;         // 0x0084     |
    PMEM3 : longword;         // 0x0088     |
    PATT3 : longword;         // 0x008C     | Bank 3
    res3  : longword;         // 0x0090     |
    ECCR3 : longword;         // 0x0094    /

    res4  : array [0..1] of longword;   // 0x0098 - 0x009C

    PCR4  : longword;         // 0x00A0    \
    SR4   : longword;         // 0x00A4     |
    PMEM4 : longword;         // 0x00A8     | Bank 4
    PATT4 : longword;         // 0x00AC     |
    PIO4  : longword;         // 0x00B0    /

    res5  : array [0..20] of longword;   // 0x00B4 - 0x0100

    BWTR1 : longword;         // 0x0104   \
    res6  : longword;         // 0x0108    |
    BWTR2 : longword;         // 0x010C    |
    res7  : longword;         // 0x0110    | Bank 1E
    BWTR3 : longword;         // 0x0114    |
    res8  : longword;         // 0x0118    |
    BWTR4 : longword;         // 0x011C   /
  end;

//======================================================================
// DMA register type definitions
//======================================================================
type
  TDMAChannel = record        // Channel 0        // Channel 1        // Channel 2         // Channel 3        // Channel 4        // Channel 5        // Channel 6         // Channel 7
    CR   : longword;          // 0x0010           // 0x0028           // 0x0040            // 0x0058           // 0x0070           // 0x0088           // 0x00A0            // 0x00B8
    NDTR : longword;          // 0x0014           // 0x002C           // 0x0044            // 0x005C           // 0x0074           // 0x008C           // 0x00A4            // 0x00BC
    PAR  : longword;          // 0x0018           // 0x0030           // 0x0048            // 0x0060           // 0x0078           // 0x0090           // 0x00A8            // 0x00C0
    M0AR : longword;          // 0x001C           // 0x0034           // 0x004C            // 0x0064           // 0x007C           // 0x0094           // 0x00AC            // 0x00C4
    M1AR : longword;          // 0x0020           // 0x0038           // 0x0050            // 0x0068           // 0x0080           // 0x0098           // 0x00B0            // 0x00C8
    FCR  : longword;          // 0x0024           // 0x003C           // 0x0054            // 0x006C           // 0x0084           // 0x009C           // 0x00B4            // 0x00CC
  end;

  TDMARegisters = record
    ISR     : array[0..1] of longword;     // 0x0000 - 0x0004
    IFCR    : array[0..1] of longword;     // 0x0008 - 0x000C
    CHANNEL : array[0..7] of TDMAChannel;
  end;

//======================================================================
// ADC register type definitions
//======================================================================
type
  TADCCommonRegisters = record
    CSR   : longword;         // 0x00
    CCR   : longword;         // 0x04
    CDR   : longword;         // 0x08
  end;

type
  TADCRegisters = record
    SR    : longword;         // 0x00
    CR1   : longword;         // 0x04
    CR2   : longword;         // 0x08
    SMPR  : array[0..1] of longword;     // 0x0C - 0x10
    JOFR  : array[0..3] of longword;     // 0x14 - 0x20
    HTR   : longword;         // 0x24
    LTR   : longword;         // 0x28
    SQR   : array[0..2] of longword;     // 0x2C - 0x34
    JSQR  : longword;         // 0x38
    JDR   : array[0..3] of longword;     // 0x3C - 0x48
    DR    : longword;         // 0x4C
  end;

//======================================================================
// External interrupt register type definitions
//======================================================================
type
  TEXTIRegisters = record
    IMR   : longword;         // 0x00
    EMR   : longword;         // 0x04
    RTSR  : longword;         // 0x08
    FTSR  : longword;         // 0x0C
    SWIER : longword;         // 0x10
    PR    : longword;         // 0x14
  end;

//======================================================================
// System configuration register type definitions
//======================================================================
type
  TSYSCFGRegisters = record
    MEMRM  : longword;        // 0x00
    PMC    : longword;        // 0x04
    EXTICR : array[0..3] of longword;         // 0x08 - 0x14
    res1   : longword;        // 0x18
    res2   : longword;        // 0x1C
    CMPCR  : longword;        // 0x20
  end;

//======================================================================
// Timer register type definitions
//======================================================================
type
  TTimerRegisters = record
    CR1  , res0  : word;   // 0x00
    CR2  , res1  : word;   // 0x04
    SMCR , res2  : word;   // 0x08
    DIER , res3  : word;   // 0x0C
    SR   , res4  : word;   // 0x10
    EGR  , res5  : word;   // 0x14
    CCMR1, res6  : word;   // 0x18
    CCMR2, res7  : word;   // 0x1C
    CCER , res8  : word;   // 0x20
    CNT          : longword;   // 0x24
    PSC  , res10 : word;   // 0x28
    ARR          : longword;   // 0x2C
    RCR  , res12 : word;   // 0x30
    CCR1         : longword;   // 0x34
    CCR2         : longword;   // 0x38
    CCR3         : longword;   // 0x3C
    CCR4         : longword;   // 0x40
    BDTR , res17 : word;   // 0x44
    DCR  , res18 : word;   // 0x48
    DMAR , res19 : word;   // 0x4C
  end;

//======================================================================
// Real time clock (RTC) register type definitions
//======================================================================
type
  TRTCRegisters = record
    TR       : longword;   // 0x00
    DR       : longword;   // 0x04
    CR       : longword;   // 0x08
    ISR      : longword;   // 0x0C
    PRER     : longword;   // 0x10
    WUTR     : longword;   // 0x14
    CALIBR   : longword;   // 0x08
    ALRMAR   : longword;   // 0x1C
    ALRMBR   : longword;   // 0x20
    WPR      : longword;   // 0x24
    SSR      : longword;   // 0x28
    SHIFTR   : longword;   // 0x2C
    TSTR     : longword;   // 0x30
    res0     : longword;   // 0x34
    TSSSR    : longword;   // 0x38
    CALR     : longword;   // 0x3C
    TAFCR    : longword;   // 0x40
    ALRMASSR : longword;   // 0x44
    ALRMBSSR : longword;   // 0x48
  end;

//======================================================================
// Backup register type definitions
//======================================================================
type
  TBKPRegisters = packed array[0..19] of dword;

//======================================================================
// Power control register type definitions
//======================================================================
type
  TPWRRegisters = record
    CR, res0  : word;
    CSR, res1 : word;
  end;

//======================================================================
// Independent watchdog register type definitions
//======================================================================
type
  TIWDGRegisters = record
    KR, res1   : word;
    PR, res2   : word;
    RLR, res3  : word;
    SR, res4   : word;
  end;

//======================================================================
// USB
//======================================================================
type
  TUSBOTGGlobalRegisters = record
    GOTGCTL                   : dword;      // USB_OTG Control and Status Register       Address offset : 0x00
    GOTGINT                   : dword;      // USB_OTG Interrupt Register                Address offset : 0x04
    GAHBCFG                   : dword;      // Core AHB Configuration Register           Address offset : 0x08
    GUSBCFG                   : dword;      // Core USB Configuration Register           Address offset : 0x0C
    GRSTCTL                   : dword;      // Core Reset Register                       Address offset : 0x10
    GINTSTS                   : dword;      // Core Interrupt Register                   Address offset : 0x14
    GINTMSK                   : dword;      // Core Interrupt Mask Register              Address offset : 0x18
    GRXSTSR                   : dword;      // Receive Sts Q Read Register               Address offset : 0x1C
    GRXSTSP                   : dword;      // Receive Sts Q Read & POP Register         Address offset : 0x20
    GRXFSIZ                   : dword;      // Receive FIFO Size Register                Address offset : 0x24
    DIEPTXF0_HNPTXFSIZ        : dword;      // EP0 / Non Periodic Tx FIFO Size Register  Address offset : 0x28
    HNPTXSTS                  : dword;      // Non Periodic Tx FIFO/Queue Sts reg        Address offset : 0x2C
    Reserved30: array[0..1]   of dword;      // Reserved                                  Address offset : 0x30
    GCCFG                     : dword;      // General Purpose IO Register               Address offset : 0x38
    CID                       : dword;      // User ID Register                          Address offset : 0x3C
    Reserved40 : array[0..47] of dword;      // Reserved                                  Address offset : 0x40-0xFF
    HPTXFSIZ                  : dword;      // Host Periodic Tx FIFO Size Reg            Address offset : 0x100
    DIEPTXF : array[0..15]    of dword;      // dev Periodic Transmit FIFO
  end;

type
  TUSBOTGDeviceTypeRegisters = record
    DCFG : dword;         //!< dev Configuration Register   Address offset : 0x800 */
    DCTL : dword;         //!< dev Control Register         Address offset : 0x804 */
    DSTS : dword;         //!< dev Status Register (RO)     Address offset : 0x808 */
    Reserved0C : dword;        //!< Reserved                     Address offset : 0x80C */
    DIEPMSK : dword;      // !< dev IN Endpoint Mask        Address offset : 0x810 */
    DOEPMSK : dword;      //!< dev OUT Endpoint Mask        Address offset : 0x814 */
    DAINT : dword;        //!< dev All Endpoints Itr Reg    Address offset : 0x818 */
    DAINTMSK : dword;     //!< dev All Endpoints Itr Mask   Address offset : 0x81C */
     Reserved20 : dword;       //!< Reserved                     Address offset : 0x820 */
    Reserved9 : dword;         //!< Reserved                     Address offset : 0x824 */
    DVBUSDIS : dword;     //!< dev VBUS discharge Register  Address offset : 0x828 */
    DVBUSPULSE : dword;   //!< dev VBUS Pulse Register      Address offset : 0x82C */
    DTHRCTL : dword;      //!< dev thr                      Address offset : 0x830 */
    DIEPEMPMSK : dword;   //!< dev empty msk                Address offset : 0x834 */
    DEACHINT : dword;     //!< dedicated EP interrupt       Address offset : 0x838 */
    DEACHMSK : dword;     //!< dedicated EP msk             Address offset : 0x83C */
    Reserved40 : dword;        //!< dedicated EP mask            Address offset : 0x840 */
    DINEP1MSK : dword;    //!< dedicated EP mask            Address offset : 0x844 */
     Reserved44: array[0..14] of dword;   //!< Reserved                     Address offset : 0x844-0x87C */
    DOUTEP1MSK : dword;   //!< dedicated EP msk             Address offset : 0x884 */
  end;


type
  TUSBOTGInEndpointRegisters = record
    DIEPCTL : dword;        // dev IN Endpoint Control Reg 900h + (ep_num * 20h) + 00h     */
    Reserved04 : dword;          // Reserved                       900h + (ep_num * 20h) + 04h  */
    DIEPINT : dword;        // dev IN Endpoint Itr Reg     900h + (ep_num * 20h) + 08h     */
    Reserved0C : dword;          // Reserved                       900h + (ep_num * 20h) + 0Ch  */
    DIEPTSIZ : dword;       // IN Endpoint Txfer Size   900h + (ep_num * 20h) + 10h        */
    DIEPDMA : dword;        // IN Endpoint DMA Address Reg    900h + (ep_num * 20h) + 14h  */
    DTXFSTS : dword;        //IN Endpoint Tx FIFO Status Reg 900h + (ep_num * 20h) + 18h   */
    Reserved18 : dword;           // Reserved  900h+(ep_num*20h)+1Ch-900h+ (ep_num * 20h) + 1Ch */
  end;

type
  TUSBOTGOutEndpointRegisters = record
    DOEPCTL : dword;       // dev OUT Endpoint Control Reg  B00h + (ep_num * 20h) + 00h*/
    Reserved04 : dword;         // Reserved                      B00h + (ep_num * 20h) + 04h*/
    DOEPINT : dword;       // dev OUT Endpoint Itr Reg      B00h + (ep_num * 20h) + 08h*/
    Reserved0C : dword;         // Reserved                      B00h + (ep_num * 20h) + 0Ch*/
    DOEPTSIZ : dword;      // dev OUT Endpoint Txfer Size   B00h + (ep_num * 20h) + 10h*/
    DOEPDMA : dword;       // dev OUT Endpoint DMA Address  B00h + (ep_num * 20h) + 14h*/
    Reserved18 : array[0..1] of dword;      // Reserved B00h + (ep_num * 20h) + 18h - B00h + (ep_num * 20h) + 1Ch*/
  end;

type
  TUSBOTGHostRegisters = record
    HCFG : dword;             // Host Configuration Register    400h*/
    HFIR : dword;             // Host Frame Interval Register   404h*/
    HFNUM : dword;            // Host Frame Nbr/Frame Remaining 408h*/
    Reserved40C : dword;           // Reserved                       40Ch*/
    HPTXSTS : dword;          // Host Periodic Tx FIFO/ Queue Status 410h*/
    HAINT : dword;            // Host All Channels Interrupt Register 414h*/
    HAINTMSK : dword;         // Host All Channels Interrupt Mask 418h*/
  end;

type
  TUSBOTGHostChannelRegisters = record
    HCCHAR : dword;
    HCSPLT : dword;
    HCINT : dword;
    HCINTMSK : dword;
    HCTSIZ : dword;
    HCDMA : dword;
    Reserved : array[0..1] of dword;
  end;









    TWWDGRegisters = record
    CR, res2,
    CFR, res3,
    SR, res4: word;
    end;

    TUSBRegisters = record
    EPR: array[0..7] of longword;

    res: array[0..7] of longword;

    CNTR, res1,
    ISTR, res2,
    FNR, res3: Word;
    DADDR: byte; res4: word; res5: byte;
    BTABLE: Word;
    end;

    TUSBMem = packed array[0..511] of byte;

    TCANMailbox = record
    IR,
    DTR,
    DLR,
    DHR: longword;
    end;

    TCANRegisters = record
    MCR,
    MSR,
    TSR,
    RF0R,
    RF1R,
    IER,
    ESR,
    BTR: longword;

    res5: array[$020..$17F] of byte;

    TX: array[0..2] of TCANMailbox;
    RX: array[0..2] of TCANMailbox;

    res6: array[$1D0..$1FF] of byte;

    FMR,
    FM1R,
    res9: longword;
    FS1R, res10: word;
    res11: longword;
    FFA1R, res12: word;
    res13: longword;
    FA1R, res14: word;
    res15: array[$220..$23F] of byte;

    FOR1,
    FOR2: longword;

    FB: array[1..13] of array[1..2] of longword;
    end;


    TDACRegisters = record
    CR,
    SWTRIGR: longword;

    DHR12R1, res2,
    DHR12L1, res3,
    DHR8R1, res4,
    DHR12R2, res5,
    DHR12L2, res6,
    DHR8R2, res7: word;

    DHR12RD,
    DHR12LD: longword;

    DHR8RD, res8,

    DOR1, res9,
    DOR2, res10: Word;
    end;

    TAFIORegisters = record
    EVCR,
    MAPR: longword;
    EXTICR: array[0..3] of longword;
    end;



    TSDIORegisters = record
    POWER,
    CLKCR,
    ARG: longword;
    CMD, res3,
    RESPCMD, res4: Word;
    RESP1,
    RESP2,
    RESP3,
    RESP4,
    DTIMER,
    DLEN: longword;
    DCTRL, res5: word;
    DCOUNT,
    STA,
    ICR,
    MASK,
    FIFOCNT,
    FIFO: longword;
    end;


    TCRCRegisters = record
    DR: longword;
    IDR: byte; res1: word; res2: byte;
    CR: byte;
    end;

{$ALIGN 1}

//======================================================================
// Register variables definitions
//======================================================================
var
  // RCC
  RCC : TRCCRegisters           absolute (AHB1Base + $00001000);

  // GPIO
  GPIOA : TPortRegisters        absolute (AHB2Base + $00000000);
  GPIOB : TPortRegisters        absolute (AHB2Base + $00000400);
  GPIOC : TPortRegisters        absolute (AHB2Base + $00000800);
  GPIOD : TPortRegisters        absolute (AHB2Base + $00000C00);
  GPIOF : TPortRegisters        absolute (AHB2Base + $00001400);


{




#define USB_OTG_FS_PERIPH_BASE               ((uint32_t )0x50000000)
#define USB_OTG_GLOBAL_BASE                  ((uint32_t )0x000)
#define USB_OTG_DEVICE_BASE                  ((uint32_t )0x800)
#define USB_OTG_IN_ENDPOINT_BASE             ((uint32_t )0x900)
#define USB_OTG_OUT_ENDPOINT_BASE            ((uint32_t )0xB00)
#define USB_OTG_EP_REG_SIZE                  ((uint32_t )0x20)
#define USB_OTG_HOST_BASE                    ((uint32_t )0x400)
#define USB_OTG_HOST_PORT_BASE               ((uint32_t )0x440)
#define USB_OTG_HOST_CHANNEL_BASE            ((uint32_t )0x500)
#define USB_OTG_HOST_CHANNEL_SIZE            ((uint32_t )0x20)
#define USB_OTG_PCGCCTL_BASE                 ((uint32_t )0xE00)
#define USB_OTG_FIFO_BASE                    ((uint32_t )0x1000)
#define USB_OTG_FIFO_SIZE                    ((uint32_t )0x1000)
#define USB_OTG_FS          ((USB_OTG_GlobalTypeDef *) USB_OTG_FS_PERIPH_BASE)


}










(*





  AFIO: TAFIORegisters   absolute (APB2Base+$0);
  EXTI: TEXTIRegisters   absolute (APB2Base+$0400);


  { Timers }
  Timer1: TTimerRegisters  absolute (APB2Base+$2C00);
  Timer2: TTimerRegisters  absolute (APB1Base+$0000);
  Timer3: TTimerRegisters  absolute (APB1Base+$0400);
  Timer4: TTimerRegisters  absolute (APB1Base+$0800);
  Timer5: TTimerRegisters  absolute (APB1Base+$0C00);
  Timer6: TTimerRegisters  absolute (APB1Base+$1000);
  Timer7: TTimerRegisters  absolute (APB1Base+$1400);
  Timer8: TTimerRegisters  absolute (APB2Base+$3400);


  { WDG }
  WWDG: TWWDGRegisters     absolute (APB1Base+$2C00);
  IWDG: TIWDGRegisters     absolute (APB1Base+$3000);


  { USB }
  USB: TUSBRegisters     absolute (APB1Base+$5C00);
  USBMem: TUSBMem                        absolute (APB1Base+$6000);

  { CAN }
  CAN: TCANRegisters     absolute (APB1Base+$6800);


  { DAC }
  DAC: TDACRegisters     absolute (APB1Base+$7400);


  { SDIO }
  SDIO: TSDIORegisters   absolute (APB2Base+$8000);

  { DMA }
  DMA2: TDMARegisters      absolute (AHBBase+$0000);
  DMA2: TDMARegisters      absolute (AHBBase+$0400);



  { CRC }
  CRC: TCRCRegisters     absolute (AHBBase+$3000);      *)

implementation

procedure NMI_interrupt; external name 'NMI_interrupt';
procedure Hardfault_interrupt; external name 'Hardfault_interrupt';
procedure MemManage_interrupt; external name 'MemManage_interrupt';
procedure BusFault_interrupt; external name 'BusFault_interrupt';
procedure UsageFault_interrupt; external name 'UsageFault_interrupt';
procedure SWI_interrupt; external name 'SWI_interrupt';
procedure DebugMonitor_interrupt; external name 'DebugMonitor_interrupt';
procedure PendingSV_interrupt; external name 'PendingSV_interrupt';
procedure SysTick_interrupt; external name 'SysTick_interrupt';

procedure WWDG_IRQHandler; external name 'WWDG_IRQHandler';
procedure PVD_IRQHandler; external name 'PVD_IRQHandler';
procedure TAMP_STAMP_IRQHandler; external name 'TAMP_STAMP_IRQHandler';
procedure RTC_WKUP_IRQHandler; external name 'RTC_WKUP_IRQHandler';
procedure FLASH_IRQHandler; external name 'FLASH_IRQHandler';
procedure RCC_IRQHandler; external name 'RCC_IRQHandler';
procedure EXTI0_IRQHandler; external name 'EXTI0_IRQHandler';
procedure EXTI1_IRQHandler; external name 'EXTI1_IRQHandler';
procedure EXTI2_IRQHandler; external name 'EXTI2_IRQHandler';
procedure EXTI3_IRQHandler; external name 'EXTI3_IRQHandler';
procedure EXTI4_IRQHandler; external name 'EXTI4_IRQHandler';
procedure DMA1_Stream0_IRQHandler; external name 'DMA1_Stream0_IRQHandler';
procedure DMA1_Stream1_IRQHandler; external name 'DMA1_Stream1_IRQHandler';
procedure DMA1_Stream2_IRQHandler; external name 'DMA1_Stream2_IRQHandler';
procedure DMA1_Stream3_IRQHandler; external name 'DMA1_Stream3_IRQHandler';
procedure DMA1_Stream4_IRQHandler; external name 'DMA1_Stream4_IRQHandler';
procedure DMA1_Stream5_IRQHandler; external name 'DMA1_Stream5_IRQHandler';
procedure DMA1_Stream6_IRQHandler; external name 'DMA1_Stream6_IRQHandler';
procedure ADC_IRQHandler; external name 'ADC_IRQHandler';
procedure CAN1_TX_IRQHandler; external name 'CAN1_TX_IRQHandler';
procedure CAN1_RX0_IRQHandler; external name 'CAN1_RX0_IRQHandler';
procedure CAN1_RX1_IRQHandler; external name 'CAN1_RX1_IRQHandler';
procedure CAN1_SCE_IRQHandler; external name 'CAN1_SCE_IRQHandler';
procedure EXTI9_5_IRQHandler; external name 'EXTI9_5_IRQHandler';
procedure TIM1_BRK_TIM9_IRQHandler; external name 'TIM1_BRK_TIM9_IRQHandler';
procedure TIM1_UP_TIM10_IRQHandler; external name 'TIM1_UP_TIM10_IRQHandler';
procedure TIM1_TRG_COM_TIM11_IRQHandler; external name 'TIM1_TRG_COM_TIM11_IRQHandler';
procedure TIM1_CC_IRQHandler; external name 'TIM1_CC_IRQHandler';
procedure TIM2_IRQHandler; external name 'TIM2_IRQHandler';
procedure TIM3_IRQHandler; external name 'TIM3_IRQHandler';
procedure TIM4_IRQHandler; external name 'TIM4_IRQHandler';
procedure I2C1_EV_IRQHandler; external name 'I2C1_EV_IRQHandler';
procedure I2C1_ER_IRQHandler; external name 'I2C1_ER_IRQHandler';
procedure I2C2_EV_IRQHandler; external name 'I2C2_EV_IRQHandler';
procedure I2C2_ER_IRQHandler; external name 'I2C2_ER_IRQHandler';
procedure SPI1_IRQHandler; external name 'SPI1_IRQHandler';
procedure SPI2_IRQHandler; external name 'SPI2_IRQHandler';
procedure USART1_IRQHandler; external name 'USART1_IRQHandler';
procedure USART2_IRQHandler; external name 'USART2_IRQHandler';
procedure USART3_IRQHandler; external name 'USART3_IRQHandler';
procedure EXTI15_10_IRQHandler; external name 'EXTI15_10_IRQHandler';
procedure RTC_Alarm_IRQHandler; external name 'RTC_Alarm_IRQHandler';
procedure OTG_FS_WKUP_IRQHandler; external name 'OTG_FS_WKUP_IRQHandler';
procedure TIM8_BRK_TIM12_IRQHandler; external name 'TIM8_BRK_TIM12_IRQHandler';
procedure TIM8_UP_TIM13_IRQHandler; external name 'TIM8_UP_TIM13_IRQHandler';
procedure TIM8_TRG_COM_TIM14_IRQHandler; external name 'TIM8_TRG_COM_TIM14_IRQHandler';
procedure TIM8_CC_IRQHandler; external name 'TIM8_CC_IRQHandler';
procedure DMA1_Stream7_IRQHandler; external name 'DMA1_Stream7_IRQHandler';
procedure FSMC_IRQHandler; external name 'FSMC_IRQHandler';
procedure SDIO_IRQHandler; external name 'SDIO_IRQHandler';
procedure TIM5_IRQHandler; external name 'TIM5_IRQHandler';
procedure SPI3_IRQHandler; external name 'SPI3_IRQHandler';
procedure UART4_IRQHandler; external name 'UART4_IRQHandler';
procedure UART5_IRQHandler; external name 'UART5_IRQHandler';
procedure TIM6_DAC_IRQHandler; external name 'TIM6_DAC_IRQHandler';
procedure TIM7_IRQHandler; external name 'TIM7_IRQHandler';
procedure DMA2_Stream0_IRQHandler; external name 'DMA2_Stream0_IRQHandler';
procedure DMA2_Stream1_IRQHandler; external name 'DMA2_Stream1_IRQHandler';
procedure DMA2_Stream2_IRQHandler; external name 'DMA2_Stream2_IRQHandler';
procedure DMA2_Stream3_IRQHandler; external name 'DMA2_Stream3_IRQHandler';
procedure DMA2_Stream4_IRQHandler; external name 'DMA2_Stream4_IRQHandler';
procedure ETH_IRQHandler; external name 'ETH_IRQHandler';
procedure ETH_WKUP_IRQHandler; external name 'ETH_WKUP_IRQHandler';
procedure CAN2_TX_IRQHandler; external name 'CAN2_TX_IRQHandler';
procedure CAN2_RX0_IRQHandler; external name 'CAN2_RX0_IRQHandler';
procedure CAN2_RX1_IRQHandler; external name 'CAN2_RX1_IRQHandler';
procedure CAN2_SCE_IRQHandler; external name 'CAN2_SCE_IRQHandler';
procedure OTG_FS_IRQHandler; external name 'OTG_FS_IRQHandler';
procedure DMA2_Stream5_IRQHandler; external name 'DMA2_Stream5_IRQHandler';
procedure DMA2_Stream6_IRQHandler; external name 'DMA2_Stream6_IRQHandler';
procedure DMA2_Stream7_IRQHandler; external name 'DMA2_Stream7_IRQHandler';
procedure USART6_IRQHandler; external name 'USART6_IRQHandler';
procedure I2C3_EV_IRQHandler; external name 'I2C3_EV_IRQHandler';
procedure I2C3_ER_IRQHandler; external name 'I2C3_ER_IRQHandler';
procedure OTG_HS_EP1_OUT_IRQHandler; external name 'OTG_HS_EP1_OUT_IRQHandler';
procedure OTG_HS_EP1_IN_IRQHandler; external name 'OTG_HS_EP1_IN_IRQHandler';
procedure OTG_HS_WKUP_IRQHandler; external name 'OTG_HS_WKUP_IRQHandler';
procedure OTG_HS_IRQHandler; external name 'OTG_HS_IRQHandler';
procedure DCMI_IRQHandler; external name 'DCMI_IRQHandler';
procedure CRYP_IRQHandler; external name 'CRYP_IRQHandler';
procedure HASH_RNG_IRQHandler; external name 'HASH_RNG_IRQHandler';
procedure FPU_IRQHandler; external name 'FPU_IRQHandler';

{$i cortexm0_start.inc}

procedure Vectors; assembler; nostackframe;
label interrupt_vectors;
asm
   .section ".init.interrupt_vectors"
interrupt_vectors:
   .long _stack_top
   .long Startup
   .long NMI_interrupt
   .long Hardfault_interrupt
   .long MemManage_interrupt
   .long BusFault_interrupt
   .long UsageFault_interrupt
   .long 0
   .long 0
   .long 0
   .long 0
   .long SWI_interrupt
   .long DebugMonitor_interrupt
   .long 0
   .long PendingSV_interrupt
   .long SysTick_interrupt
   .long WWDG_IRQHandler
   .long PVD_IRQHandler
   .long TAMP_STAMP_IRQHandler
   .long RTC_WKUP_IRQHandler
   .long FLASH_IRQHandler
   .long RCC_IRQHandler
   .long EXTI0_IRQHandler
   .long EXTI1_IRQHandler
   .long EXTI2_IRQHandler
   .long EXTI3_IRQHandler
   .long EXTI4_IRQHandler
   .long DMA1_Stream0_IRQHandler
   .long DMA1_Stream1_IRQHandler
   .long DMA1_Stream2_IRQHandler
   .long DMA1_Stream3_IRQHandler
   .long DMA1_Stream4_IRQHandler
   .long DMA1_Stream5_IRQHandler
   .long DMA1_Stream6_IRQHandler
   .long ADC_IRQHandler
   .long CAN1_TX_IRQHandler
   .long CAN1_RX0_IRQHandler
   .long CAN1_RX1_IRQHandler
   .long CAN1_SCE_IRQHandler
   .long EXTI9_5_IRQHandler
   .long TIM1_BRK_TIM9_IRQHandler
   .long TIM1_UP_TIM10_IRQHandler
   .long TIM1_TRG_COM_TIM11_IRQHandler
   .long TIM1_CC_IRQHandler
   .long TIM2_IRQHandler
   .long TIM3_IRQHandler
   .long TIM4_IRQHandler
   .long I2C1_EV_IRQHandler
   .long I2C1_ER_IRQHandler
   .long I2C2_EV_IRQHandler
   .long I2C2_ER_IRQHandler
   .long SPI1_IRQHandler
   .long SPI2_IRQHandler
   .long USART1_IRQHandler
   .long USART2_IRQHandler
   .long USART3_IRQHandler
   .long EXTI15_10_IRQHandler
   .long RTC_Alarm_IRQHandler
   .long OTG_FS_WKUP_IRQHandler
   .long TIM8_BRK_TIM12_IRQHandler
   .long TIM8_UP_TIM13_IRQHandler
   .long TIM8_TRG_COM_TIM14_IRQHandler
   .long TIM8_CC_IRQHandler
   .long DMA1_Stream7_IRQHandler
   .long FSMC_IRQHandler
   .long SDIO_IRQHandler
   .long TIM5_IRQHandler
   .long SPI3_IRQHandler
   .long UART4_IRQHandler
   .long UART5_IRQHandler
   .long TIM6_DAC_IRQHandler
   .long TIM7_IRQHandler
   .long DMA2_Stream0_IRQHandler
   .long DMA2_Stream1_IRQHandler
   .long DMA2_Stream2_IRQHandler
   .long DMA2_Stream3_IRQHandler
   .long DMA2_Stream4_IRQHandler
   .long ETH_IRQHandler
   .long ETH_WKUP_IRQHandler
   .long CAN2_TX_IRQHandler
   .long CAN2_RX0_IRQHandler
   .long CAN2_RX1_IRQHandler
   .long CAN2_SCE_IRQHandler
   .long OTG_FS_IRQHandler
   .long DMA2_Stream5_IRQHandler
   .long DMA2_Stream6_IRQHandler
   .long DMA2_Stream7_IRQHandler
   .long USART6_IRQHandler
   .long I2C3_EV_IRQHandler
   .long I2C3_ER_IRQHandler
   .long OTG_HS_EP1_OUT_IRQHandler
   .long OTG_HS_EP1_IN_IRQHandler
   .long OTG_HS_WKUP_IRQHandler
   .long OTG_HS_IRQHandler
   .long DCMI_IRQHandler
   .long CRYP_IRQHandler
   .long HASH_RNG_IRQHandler
   .long FPU_IRQHandler

   .weak NMI_interrupt
   .weak Hardfault_interrupt
   .weak MemManage_interrupt
   .weak BusFault_interrupt
   .weak UsageFault_interrupt
   .weak SWI_interrupt
   .weak DebugMonitor_interrupt
   .weak PendingSV_interrupt
   .weak SysTick_interrupt

   .weak WWDG_IRQHandler
   .weak PVD_IRQHandler
   .weak TAMP_STAMP_IRQHandler
   .weak RTC_WKUP_IRQHandler
   .weak FLASH_IRQHandler
   .weak RCC_IRQHandler
   .weak EXTI0_IRQHandler
   .weak EXTI1_IRQHandler
   .weak EXTI2_IRQHandler
   .weak EXTI3_IRQHandler
   .weak EXTI4_IRQHandler
   .weak DMA1_Stream0_IRQHandler
   .weak DMA1_Stream1_IRQHandler
   .weak DMA1_Stream2_IRQHandler
   .weak DMA1_Stream3_IRQHandler
   .weak DMA1_Stream4_IRQHandler
   .weak DMA1_Stream5_IRQHandler
   .weak DMA1_Stream6_IRQHandler
   .weak ADC_IRQHandler
   .weak CAN1_TX_IRQHandler
   .weak CAN1_RX0_IRQHandler
   .weak CAN1_RX1_IRQHandler
   .weak CAN1_SCE_IRQHandler
   .weak EXTI9_5_IRQHandler
   .weak TIM1_BRK_TIM9_IRQHandler
   .weak TIM1_UP_TIM10_IRQHandler
   .weak TIM1_TRG_COM_TIM11_IRQHandler
   .weak TIM1_CC_IRQHandler
   .weak TIM2_IRQHandler
   .weak TIM3_IRQHandler
   .weak TIM4_IRQHandler
   .weak I2C1_EV_IRQHandler
   .weak I2C1_ER_IRQHandler
   .weak I2C2_EV_IRQHandler
   .weak I2C2_ER_IRQHandler
   .weak SPI1_IRQHandler
   .weak SPI2_IRQHandler
   .weak USART1_IRQHandler
   .weak USART2_IRQHandler
   .weak USART3_IRQHandler
   .weak EXTI15_10_IRQHandler
   .weak RTC_Alarm_IRQHandler
   .weak OTG_FS_WKUP_IRQHandler
   .weak TIM8_BRK_TIM12_IRQHandler
   .weak TIM8_UP_TIM13_IRQHandler
   .weak TIM8_TRG_COM_TIM14_IRQHandler
   .weak TIM8_CC_IRQHandler
   .weak DMA1_Stream7_IRQHandler
   .weak FSMC_IRQHandler
   .weak SDIO_IRQHandler
   .weak TIM5_IRQHandler
   .weak SPI3_IRQHandler
   .weak UART4_IRQHandler
   .weak UART5_IRQHandler
   .weak TIM6_DAC_IRQHandler
   .weak TIM7_IRQHandler
   .weak DMA2_Stream0_IRQHandler
   .weak DMA2_Stream1_IRQHandler
   .weak DMA2_Stream2_IRQHandler
   .weak DMA2_Stream3_IRQHandler
   .weak DMA2_Stream4_IRQHandler
   .weak ETH_IRQHandler
   .weak ETH_WKUP_IRQHandler
   .weak CAN2_TX_IRQHandler
   .weak CAN2_RX0_IRQHandler
   .weak CAN2_RX1_IRQHandler
   .weak CAN2_SCE_IRQHandler
   .weak OTG_FS_IRQHandler
   .weak DMA2_Stream5_IRQHandler
   .weak DMA2_Stream6_IRQHandler
   .weak DMA2_Stream7_IRQHandler
   .weak USART6_IRQHandler
   .weak I2C3_EV_IRQHandler
   .weak I2C3_ER_IRQHandler
   .weak OTG_HS_EP1_OUT_IRQHandler
   .weak OTG_HS_EP1_IN_IRQHandler
   .weak OTG_HS_WKUP_IRQHandler
   .weak OTG_HS_IRQHandler
   .weak DCMI_IRQHandler
   .weak CRYP_IRQHandler
   .weak HASH_RNG_IRQHandler
   .weak FPU_IRQHandler


   .set NMI_interrupt                    , HaltProc
   .set Hardfault_interrupt              , HaltProc
   .set MemManage_interrupt              , HaltProc
   .set BusFault_interrupt               , HaltProc
   .set UsageFault_interrupt             , HaltProc
   .set SWI_interrupt                    , HaltProc
   .set DebugMonitor_interrupt           , HaltProc
   .set PendingSV_interrupt              , HaltProc
   .set SysTick_interrupt                , HaltProc

   .set WWDG_IRQHandler                  , HaltProc
   .set PVD_IRQHandler                   , HaltProc
   .set TAMP_STAMP_IRQHandler            , HaltProc
   .set RTC_WKUP_IRQHandler              , HaltProc
   .set FLASH_IRQHandler                 , HaltProc
   .set RCC_IRQHandler                   , HaltProc
   .set EXTI0_IRQHandler                 , HaltProc
   .set EXTI1_IRQHandler                 , HaltProc
   .set EXTI2_IRQHandler                 , HaltProc
   .set EXTI3_IRQHandler                 , HaltProc
   .set EXTI4_IRQHandler                 , HaltProc
   .set DMA1_Stream0_IRQHandler          , HaltProc
   .set DMA1_Stream1_IRQHandler          , HaltProc
   .set DMA1_Stream2_IRQHandler          , HaltProc
   .set DMA1_Stream3_IRQHandler          , HaltProc
   .set DMA1_Stream4_IRQHandler          , HaltProc
   .set DMA1_Stream5_IRQHandler          , HaltProc
   .set DMA1_Stream6_IRQHandler          , HaltProc
   .set ADC_IRQHandler                   , HaltProc
   .set CAN1_TX_IRQHandler               , HaltProc
   .set CAN1_RX0_IRQHandler              , HaltProc
   .set CAN1_RX1_IRQHandler              , HaltProc
   .set CAN1_SCE_IRQHandler              , HaltProc
   .set EXTI9_5_IRQHandler               , HaltProc
   .set TIM1_BRK_TIM9_IRQHandler         , HaltProc
   .set TIM1_UP_TIM10_IRQHandler         , HaltProc
   .set TIM1_TRG_COM_TIM11_IRQHandler    , HaltProc
   .set TIM1_CC_IRQHandler               , HaltProc
   .set TIM2_IRQHandler                  , HaltProc
   .set TIM3_IRQHandler                  , HaltProc
   .set TIM4_IRQHandler                  , HaltProc
   .set I2C1_EV_IRQHandler               , HaltProc
   .set I2C1_ER_IRQHandler               , HaltProc
   .set I2C2_EV_IRQHandler               , HaltProc
   .set I2C2_ER_IRQHandler               , HaltProc
   .set SPI1_IRQHandler                  , HaltProc
   .set SPI2_IRQHandler                  , HaltProc
   .set USART1_IRQHandler                , HaltProc
   .set USART2_IRQHandler                , HaltProc
   .set USART3_IRQHandler                , HaltProc
   .set EXTI15_10_IRQHandler             , HaltProc
   .set RTC_Alarm_IRQHandler             , HaltProc
   .set OTG_FS_WKUP_IRQHandler           , HaltProc
   .set TIM8_BRK_TIM12_IRQHandler        , HaltProc
   .set TIM8_UP_TIM13_IRQHandler         , HaltProc
   .set TIM8_TRG_COM_TIM14_IRQHandler    , HaltProc
   .set TIM8_CC_IRQHandler               , HaltProc
   .set DMA1_Stream7_IRQHandler          , HaltProc
   .set FSMC_IRQHandler                  , HaltProc
   .set SDIO_IRQHandler                  , HaltProc
   .set TIM5_IRQHandler                  , HaltProc
   .set SPI3_IRQHandler                  , HaltProc
   .set UART4_IRQHandler                 , HaltProc
   .set UART5_IRQHandler                 , HaltProc
   .set TIM6_DAC_IRQHandler              , HaltProc
   .set TIM7_IRQHandler                  , HaltProc
   .set DMA2_Stream0_IRQHandler          , HaltProc
   .set DMA2_Stream1_IRQHandler          , HaltProc
   .set DMA2_Stream2_IRQHandler          , HaltProc
   .set DMA2_Stream3_IRQHandler          , HaltProc
   .set DMA2_Stream4_IRQHandler          , HaltProc
   .set ETH_IRQHandler                   , HaltProc
   .set ETH_WKUP_IRQHandler              , HaltProc
   .set CAN2_TX_IRQHandler               , HaltProc
   .set CAN2_RX0_IRQHandler              , HaltProc
   .set CAN2_RX1_IRQHandler              , HaltProc
   .set CAN2_SCE_IRQHandler              , HaltProc
   .set OTG_FS_IRQHandler                , HaltProc
   .set DMA2_Stream5_IRQHandler          , HaltProc
   .set DMA2_Stream6_IRQHandler          , HaltProc
   .set DMA2_Stream7_IRQHandler          , HaltProc
   .set USART6_IRQHandler                , HaltProc
   .set I2C3_EV_IRQHandler               , HaltProc
   .set I2C3_ER_IRQHandler               , HaltProc
   .set OTG_HS_EP1_OUT_IRQHandler        , HaltProc
   .set OTG_HS_EP1_IN_IRQHandler         , HaltProc
   .set OTG_HS_WKUP_IRQHandler           , HaltProc
   .set OTG_HS_IRQHandler                , HaltProc
   .set DCMI_IRQHandler                  , HaltProc
   .set CRYP_IRQHandler                  , HaltProc
   .set HASH_RNG_IRQHandler              , HaltProc
   .set FPU_IRQHandler                   , HaltProc

   .text
end;

end.
