module Admin::UsersHelper


def all_iso_codes
		
		  {
        "+1(CA)": "+1",
        "+1(US)": "+1",
        "+7(RU)": "+7",
        "+20(EG)": "+20",
        "+27(ZA)": "+27",
        "+30(GR)": "+30",
        "+31(NL)": "+31",
        "+32(BE)": "+32",
        "+33(FR)": "+33",
        "+34(ES)": "+34",
        "+36(HU)": "+36",
        "+39(IT)": "+39",
        "+40(RO)": "+40",
        "+41(CH)": "+41",
        "+43(AT)": "+43",
        "+44(GB)": "+44",
        "+44(IM)": "+44",
        "+44(JE)": "+44",
        "+44(GG)": "+44",
        "+45(DK)": "+45",
        "+46(SE)": "+46",
        "+47(NO)": "+47",
        "+47(SJ)": "+47",
        "+48(PL)": "+48",
        "+49(DE)": "+49",
        "+51(PE)": "+51",
        "+52(MX)": "+52",
        "+53(CU)": "+53",
        "+54(AR)": "+54",
        "+55(BR)": "+55",
        "+56(CL)": "+56",
        "+57(CO)": "+57",
        "+58(VE)": "+58",
        "+60(MY)": "+60",
        "+61(AU)": "+61",
        "+61(CX)": "+61",
        "+61(CC)": "+61",
        "+62(ID)": "+62",
        "+63(PH)": "+63",
        "+64(NZ)": "+64",
        "+65(SG)": "+65",
        "+66(TH)": "+66",
        "+77(KZ)": "+77",
        "+81(JP)": "+81",
        "+82(KR)": "+82",
        "+84(VN)": "+84",
        "+86(CN)": "+86",
        "+90(TR)": "+90",
        "+91(IN)": "+91",
        "+92(PK)": "+92",
        "+93(AF)": "+93",
        "+94(LK)": "+94",
        "+95(MM)": "+95",
        "+98(IR)": "+98",
        "+211(SS)": "+211",
        "+212(MA)": "+212",
        "+213(DZ)": "+213",
        "+216(TN)": "+216",
        "+218(LY)": "+218",
        "+220(GM)": "+220",
        "+221(SN)": "+221",
        "+222(MR)": "+222",
        "+223(ML)": "+223",
        "+224(GN)": "+224",
        "+225(CI)": "+225",
        "+226(BF)": "+226",
        "+227(NE)": "+227",
        "+228(TG)": "+228",
        "+229(BJ)": "+229",
        "+230(MU)": "+230",
        "+233(GH)": "+233",
        "+231(LR)": "+231",
        "+232(SL)": "+232",
        "+234(NG)": "+234",
        "+235(TD)": "+235",
        "+236(CF)": "+236",
        "+237(CM)": "+237",
        "+238(CV)": "+238",
        "+239(ST)": "+239",
        "+240(GQ)": "+240",
        "+241(GA)": "+241",
        "+242(CG)": "+242",
        "+243(CD)": "+243",
        "+244(AO)": "+244",
        "+245(GW)": "+245",
        "+246(IO)": "+246",
        "+248(SC)": "+248",
        "+249(SD)": "+249",
        "+250(RW)": "+250",
        "+251(ET)": "+251",
        "+252(SO)": "+252",
        "+253(DJ)": "+253",
        "+254(KE)": "+254",
        "+255(TZ)": "+255",
        "+256(UG)": "+256",
        "+257(BI)": "+257",
        "+258(MZ)": "+258",
        "+260(ZM)": "+260",
        "+261(MG)": "+261",
        "+262(YT)": "+262",
        "+262(RE)": "+262",
        "+263(ZW)": "+263",
        "+264(NA)": "+264",
        "+265(MW)": "+265",
        "+266(LS)": "+266",
        "+267(BW)": "+267",
        "+268(SZ)": "+268",
        "+269(KM)": "+269",
        "+290(SH)": "+290",
        "+291(ER)": "+291",
        "+297(AW)": "+297",
        "+298(FO)": "+298",
        "+299(GL)": "+299",
        "+345(KY) ": "+345",
        "+350(GI)": "+350",
        "+351(PT)": "+351",
        "+352(LU)": "+352",
        "+353(IE)": "+353",
        "+354(IS)": "+354",
        "+355(AL)": "+355",
        "+356(MT)": "+356",
        "+357(CY)": "+357",
        "+358(AX)": "+358",
        "+358(FI)": "+358",
        "+359(BG)": "+359",
        "+370(LT)": "+370",
        "+371(LV)": "+371",
        "+372(EE)": "+372",
        "+373(MD)": "+373",
        "+374(AM)": "+374",
        "+375(BY)": "+375",
        "+376(AD)": "+376",
        "+377(MC)": "+377",
        "+378(SM)": "+378",
        "+379(VA)": "+379",
        "+380(UA)": "+380",
        "+381(RS)": "+381",
        "+382(ME)": "+382",
        "+385(HR)": "+385",
        "+386(SI)": "+386",
        "+387(BA)": "+387",
        "+389(MK)": "+389",
        "+420(CZ)": "+420",
        "+421(SK)": "+421",
        "+423(LI)": "+423",
        "+500(FK)": "+500",
        "+500(GS)": "+500",
        "+501(BZ)": "+501",
        "+502(GT)": "+502",
        "+503(SV)": "+503",
        "+504(HN)": "+504",
        "+505(NI)": "+505",
        "+506(CR)": "+506",
        "+507(PA)": "+507",
        "+508(PM)": "+508",
        "+509(HT)": "+509",
        "+590(MF)": "+590",
        "+590(GP)": "+590",
        "+590(BL)": "+590",
        "+591(BO)": "+591",
        "+593(EC)": "+593",
        "+594(GF)": "+594",
        "+595(PY)": "+595",
        "+595(GY)": "+595",
        "+596(MQ)": "+596",
        "+597(SR)": "+597",
        "+598(UY)": "+598",
        "+599(AN)": "+599",
        "+670(TL)": "+670",
        "+672(AQ)": "+672",
        "+672(NF)": "+672",
        "+673(BN)": "+673",
        "+674(NR)": "+674",
        "+675(PG)": "+675",
        "+676(TO)": "+676",
        "+677(SB)": "+677",
        "+678(VU)": "+678",
        "+679(FJ)": "+679",
        "+680(PW)": "+680",
        "+681(WF)": "+681",
        "+682(CK)": "+682",
        "+683(NU)": "+683",
        "+685(WS)": "+685",
        "+686(KI)": "+686",
        "+687(NC)": "+687",
        "+688(TV)": "+688",
        "+689(PF)": "+689",
        "+690(TK)": "+690",
        "+691(FM)": "+691",
        "+692(MH)": "+692",
        "+850(KP)": "+850",
        "+852(HK)": "+852",
        "+853(MO)": "+853",
        "+855(KH)": "+855",
        "+856(LA)": "+856",
        "+872(PN)": "+872",
        "+880(BD)": "+880",
        "+886(TW)": "+886",
        "+973(BH)": "+973",
        "+960(MV)": "+960",
        "+961(LB)": "+961",
        "+962(JO)": "+962",
        "+963(SY)": "+963",
        "+964(IQ)": "+964",
        "+965(KW)": "+965",
        "+966(SA)": "+966",
        "+967(YE)": "+967",
        "+968(OM)": "+968",
        "+970(PS)": "+970",
        "+971(AE)": "+971",
        "+972(IL)": "+972",
        "+974(QA)": "+974",
        "+975(BT)": "+975",
        "+976(MN)": "+976",
        "+977(NP)": "+977",
        "+992(TJ)": "+992",
        "+993(TM)": "+993",
        "+994(AZ)": "+994",
        "+995(GE)": "+995",
        "+996(KG)": "+996",
        "+998(UZ)": "+998",
        "+1441(BM)": "+1441",
        "+1242(BS)": "+1242",
        "+1246(BB)": "+1246",
        "+1284(VG)": "+1284",
        "+1340(VI)": "+1340",
        "+1649(TC)": "+1649",
        "+1684(AS)": "+1684",
        "+1264(AI)": "+1264",
        "+1268(AG)": "+1268",
        "+1767(DM)": "+1767",
        "+1849(DO)": "+1849",
        "+1473(GD)": "+1473",
        "+1664(MS)": "+1664",
        "+1670(MP)": "+1670",
        "+1671(GU)": "+1671",
        "+1758(LC)": "+1758",
        "+1784(VC)": "+1784",
        "+1868(TT)": "+1868",
        "+1869(KN)": "+1869",
        "+1876(JM)": "+1876",
        "+1939(PR)": "+1939"
        


		}

	end

end
