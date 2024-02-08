//+------------------------------------------------------------------+
//|                                              GridLotsManager.mq4 |
//|                        Copyright 2022, Achmad Chaerul Rizal. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022,bot.mt4@gmail.com"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//exness real

  //Menentukan Pengaturan Proteksi EA
// FALSE=0 ; TRUE=1;
bool     Lock_By_Number = 0;
/*hidden*/int      Lock_Number             =  0; // Fill Account Number
//untuk extern Info Akun
 string   Display_Number                 = "10471254"; // Show Account Number
bool     Lock_By_Name = 0;
/*hidden*/string   Lock_Name              = "Name"; //  Fill Account Name
//untuk extern Info Akun
 string   Display_Name               = "Name"; //Show Account Name
bool     Lock_By_Password = 0;
//untuk extern input password
/*hidden*/string Lock_Password                   = "bot.mt4"; // Fill Password
string   Password                      = ""; //Password EA
bool     Lock_By_DateTime = 1;
/*hidden*/datetime dtExpired                  = D'2023.12.31'; //YYYY.MM.DD

 string NamaEA="GandewaFx";
extern string _0               = "TakeProfit";
input double  DailyTarget_     = 5;      // Daily Target[%]
double  DailyTarget            = 0;      // Daily Target[%]
input double DollarTarget      = 0; // TP Money [$]
input double  Risk             = 10000;       // Risk Account [%]
 double TP=0;
 double SL=0;
extern string  _1              = "AutoTrades";
input bool UseBuy = 1;
input bool UseSell = 1;
input bool BreakMartiBuy =0;
input bool BreakMartiSell =0;

extern string  _2              = "Allocation Balance to Trade";
extern bool    UseMyBalance    = TRUE;
extern double  MyBalance       = 100; // Balance [%]
extern double  initialAllocation      = 60; // Allocation [%]
extern string  _3              = "Draw Grid Lines";
double  StartPrice      = 0;
input int     initialMaxRange        = 6000;
input int HighestMaxRange = 50000;

extern int MultipleRange        = 1;
 //string _4               = "Count Grids";
 input int MaxOrder = 101; // MaxOrder To Open Trades
 extern int     NumLines        = 51; //NumLines on Planned
extern string _4               = "Parameter Grid Lots";
input double val_cur = 1.541; // Val. Currency
extern bool    AutoCalc        = False;
double My_DfL     = 1.3333;
 double My_InitialMultiple_Lots = 1.0;
input double PercentageFreshLots = 0.00522;
input bool ShowInfo = 1; // Show Information
input int Magic=0;
input int slip=300;
input ENUM_TIMEFRAMES BreakTime = PERIOD_M5;

double Balance = 0;double BalanceToTrade = 0;double Diff_MaxLots = 0;double Multiple = 0;double mult,prc;

double Bal_1 = 0  ; double val_diff_1 = 0 ; double multiple_val_1 = 0;
double Bal_2 = 0; double val_diff_2 =  0; double multiple_val_2 = 0;
double Bal_3 =0 ; double val_diff_3 =0 ; double multiple_val_3 = 0;
double Bal_4 = 0; double val_diff_4 = 0; double multiple_val_4 = 0;
double Bal_5 =0 ; double val_diff_5 = 0; double multiple_val_5 = 0;
double Bal_6 = 0; double val_diff_6 = 0; double multiple_val_6 = 0;
double Bal_7 = 0 ; double val_diff_7 =0 ; double multiple_val_7 = 0;
double Bal_8 = 0 ; double val_diff_8 = 0; double multiple_val_8 = 0;
double Bal_9 =  0; double val_diff_9 = 0; double multiple_val_9 = 0;
double Bal_10 =0 ; double val_diff_10=0 ; double multiple_val_10 =0 ;
double Bal_11 = 0 ; double val_diff_11=0 ; double multiple_val_11 = 0;
double Bal_12 = 0 ; double val_diff_12 = 0; double multiple_val_12 = 0;
double Bal_13 =  0; double val_diff_13 = 0; double multiple_val_13 = 0;
double Bal_14 =  0; double val_diff_14 = 0 ; double multiple_val_14 = 0;
double Bal_15 =  0; double val_diff_15 = 0 ; double multiple_val_15 = 0;
double Bal_16 =  0; double val_diff_16 = 0; double multiple_val_16 = 0;
double Bal_17 = 0 ; double val_diff_17 = 0; double multiple_val_17 = 0 ;

double   CurrentHighestLots=0;
double DfL_01_00 =0;double DfL_01_01 =0;double DfL_01_02 =0;double DfL_01_03 =0;double DfL_01_04 =0;double DfL_01_05 =0;double DfL_01_06 =0;double DfL_01_07 =0;double DfL_01_08 =0;double DfL_01_09 =0;double DfL_01_10 =0;double DfL_01_11 =0;double DfL_01_12 =0;double DfL_01_13 =0;double DfL_01_14 =0;double DfL_01_15 =0;double DfL_01_16 =0;double DfL_01_17 =0;double DfL_01_18 =0;double DfL_01_19 =0;double DfL_01_20 =0;double DfL_01_21 =0;double DfL_01_22 =0;double DfL_01_23 =0;double DfL_01_24 =0;double DfL_01_25 =0;double DfL_01_26 =0;double DfL_01_27 =0;double DfL_01_28 =0;double DfL_01_29 =0;double DfL_01_30 =0;double DfL_01_31 =0;double DfL_01_32 =0;double DfL_01_33 =0;double DfL_01_34 =0;double DfL_01_35 =0;double DfL_01_36 =0;double DfL_01_37 =0;double DfL_01_38 =0;double DfL_01_39 =0;double DfL_01_40 =0;double DfL_01_41 =0;double DfL_01_42 =0;double DfL_01_43 =0;double DfL_01_44 =0;double DfL_01_45 =0;double DfL_01_46 =0;double DfL_01_47 =0;double DfL_01_48 =0;double DfL_01_49 =0;double DfL_01_50 =0;double DfL_01_51 =0;double DfL_01_52 =0;double DfL_01_53 =0;double DfL_01_54 =0;double DfL_01_55 =0;double DfL_01_56 =0;double DfL_01_57 =0;double DfL_01_58 =0;double DfL_01_59 =0;double DfL_01_60 =0;double DfL_01_61 =0;double DfL_01_62 =0;double DfL_01_63 =0;double DfL_01_64 =0;double DfL_01_65 =0;double DfL_01_66 =0;double DfL_01_67 =0;double DfL_01_68 =0;double DfL_01_69 =0;double DfL_01_70 =0;double DfL_01_71 =0;double DfL_01_72 =0;double DfL_01_73 =0;double DfL_01_74 =0;double DfL_01_75 =0;double DfL_01_76 =0;double DfL_01_77 =0;double DfL_01_78 =0;double DfL_01_79 =0;double DfL_01_80 =0;double DfL_01_81 =0;double DfL_01_82 =0;double DfL_01_83 =0;double DfL_01_84 =0;double DfL_01_85 =0;double DfL_01_86 =0;double DfL_01_87 =0;double DfL_01_88 =0;double DfL_01_89 =0;double DfL_01_90 =0;double DfL_01_91 =0;double DfL_01_92 =0;double DfL_01_93 =0;double DfL_01_94 =0;double DfL_01_95 =0;double DfL_01_96 =0;double DfL_01_97 =0;double DfL_01_98 =0;double DfL_01_99 =0;double DfL_01_100 =0;double DfL_01_101 =0;double DfL_01_102 =0;double DfL_01_103 =0;double DfL_01_104 =0;double DfL_01_105 =0;double DfL_01_106 =0;double DfL_01_107 =0;double DfL_01_108 =0;double DfL_01_109 =0;double DfL_01_110 =0;double DfL_01_111 =0;double DfL_01_112 =0;double DfL_01_113 =0;double DfL_01_114 =0;double DfL_01_115 =0;double DfL_01_116 =0;double DfL_01_117 =0;double DfL_01_118 =0;double DfL_01_119 =0;double DfL_01_120 =0;double DfL_01_121 =0;double DfL_01_122 =0;double DfL_01_123 =0;double DfL_01_124 =0;double DfL_01_125 =0;double DfL_01_126 =0;double DfL_01_127 =0;double DfL_01_128 =0;double DfL_01_129 =0;double DfL_01_130 =0;double DfL_01_131 =0;double DfL_01_132 =0;double DfL_01_133 =0;double DfL_01_134 =0;double DfL_01_135 =0;double DfL_01_136 =0;double DfL_01_137 =0;double DfL_01_138 =0;double DfL_01_139 =0;double DfL_01_140 =0;double DfL_01_141 =0;double DfL_01_142 =0;double DfL_01_143 =0;double DfL_01_144 =0;double DfL_01_145 =0;double DfL_01_146 =0;double DfL_01_147 =0;double DfL_01_148 =0;double DfL_01_149 =0;double DfL_01_150 =0;double DfL_01_151 =0;double DfL_01_152 =0;double DfL_01_153 =0;double DfL_01_154 =0;double DfL_01_155 =0;double DfL_01_156 =0;double DfL_01_157 =0;double DfL_01_158 =0;double DfL_01_159 =0;double DfL_01_160 =0;double DfL_01_161 =0;double DfL_01_162 =0;double DfL_01_163 =0;double DfL_01_164 =0;double DfL_01_165 =0;double DfL_01_166 =0;double DfL_01_167 =0;double DfL_01_168 =0;double DfL_01_169 =0;double DfL_01_170 =0;double DfL_01_171 =0;double DfL_01_172 =0;double DfL_01_173 =0;double DfL_01_174 =0;double DfL_01_175 =0;double DfL_01_176 =0;double DfL_01_177 =0;double DfL_01_178 =0;double DfL_01_179 =0;double DfL_01_180 =0;double DfL_01_181 =0;double DfL_01_182 =0;double DfL_01_183 =0;double DfL_01_184 =0;double DfL_01_185 =0;double DfL_01_186 =0;double DfL_01_187 =0;double DfL_01_188 =0;double DfL_01_189 =0;double DfL_01_190 =0;double DfL_01_191 =0;double DfL_01_192 =0;double DfL_01_193 =0;double DfL_01_194 =0;double DfL_01_195 =0;double DfL_01_196 =0;double DfL_01_197 =0;double DfL_01_198 =0;double DfL_01_199 =0;double DfL_01_200 =0;double DfL_01_201 =0;
double Lots_00 = 0;double Lots_01 = 0;double Lots_02 = 0;double Lots_03 = 0;double Lots_04 = 0;double Lots_05 = 0;double Lots_06 = 0;double Lots_07 = 0;double Lots_08 = 0;double Lots_09 = 0;double Lots_10 = 0;double Lots_11 = 0;double Lots_12 = 0;double Lots_13 = 0;double Lots_14 = 0;double Lots_15 = 0;double Lots_16 = 0;double Lots_17 = 0;double Lots_18 = 0;double Lots_19 = 0;double Lots_20 = 0;double Lots_21 = 0;double Lots_22 = 0;double Lots_23 = 0;double Lots_24 = 0;double Lots_25 = 0;double Lots_26 = 0;double Lots_27 = 0;double Lots_28 = 0;double Lots_29 = 0;double Lots_30 = 0;double Lots_31 = 0;double Lots_32 = 0;double Lots_33 = 0;double Lots_34 = 0;double Lots_35 = 0;double Lots_36 = 0;double Lots_37 = 0;double Lots_38 = 0;double Lots_39 = 0;double Lots_40 = 0;double Lots_41 = 0;double Lots_42 = 0;double Lots_43 = 0;double Lots_44 = 0;double Lots_45 = 0;double Lots_46 = 0;double Lots_47 = 0;double Lots_48 = 0;double Lots_49 = 0;double Lots_50 = 0;double Lots_51 = 0;double Lots_52 = 0;double Lots_53 = 0;double Lots_54 = 0;double Lots_55 = 0;double Lots_56 = 0;double Lots_57 = 0;double Lots_58 = 0;double Lots_59 = 0;double Lots_60 = 0;double Lots_61 = 0;double Lots_62 = 0;double Lots_63 = 0;double Lots_64 = 0;double Lots_65 = 0;double Lots_66 = 0;double Lots_67 = 0;double Lots_68 = 0;double Lots_69 = 0;double Lots_70 = 0;double Lots_71 = 0;double Lots_72 = 0;double Lots_73 = 0;double Lots_74 = 0;double Lots_75 = 0;double Lots_76 = 0;double Lots_77 = 0;double Lots_78 = 0;double Lots_79 = 0;double Lots_80 = 0;double Lots_81 = 0;double Lots_82 = 0;double Lots_83 = 0;double Lots_84 = 0;double Lots_85 = 0;double Lots_86 = 0;double Lots_87 = 0;double Lots_88 = 0;double Lots_89 = 0;double Lots_90 = 0;double Lots_91 = 0;double Lots_92 = 0;double Lots_93 = 0;double Lots_94 = 0;double Lots_95 = 0;double Lots_96 = 0;double Lots_97 = 0;double Lots_98 = 0;double Lots_99 = 0;double Lots_100 = 0;double Lots_101 = 0;double Lots_102 = 0;double Lots_103 = 0;double Lots_104 = 0;double Lots_105 = 0;double Lots_106 = 0;double Lots_107 = 0;double Lots_108 = 0;double Lots_109 = 0;double Lots_110 = 0;double Lots_111 = 0;double Lots_112 = 0;double Lots_113 = 0;double Lots_114 = 0;double Lots_115 = 0;double Lots_116 = 0;double Lots_117 = 0;double Lots_118 = 0;double Lots_119 = 0;double Lots_120 = 0;double Lots_121 = 0;double Lots_122 = 0;double Lots_123 = 0;double Lots_124 = 0;double Lots_125 = 0;double Lots_126 = 0;double Lots_127 = 0;double Lots_128 = 0;double Lots_129 = 0;double Lots_130 = 0;double Lots_131 = 0;double Lots_132 = 0;double Lots_133 = 0;double Lots_134 = 0;double Lots_135 = 0;double Lots_136 = 0;double Lots_137 = 0;double Lots_138 = 0;double Lots_139 = 0;double Lots_140 = 0;double Lots_141 = 0;double Lots_142 = 0;double Lots_143 = 0;double Lots_144 = 0;double Lots_145 = 0;double Lots_146 = 0;double Lots_147 = 0;double Lots_148 = 0;double Lots_149 = 0;double Lots_150 = 0;double Lots_151 = 0;double Lots_152 = 0;double Lots_153 = 0;double Lots_154 = 0;double Lots_155 = 0;double Lots_156 = 0;double Lots_157 = 0;double Lots_158 = 0;double Lots_159 = 0;double Lots_160 = 0;double Lots_161 = 0;double Lots_162 = 0;double Lots_163 = 0;double Lots_164 = 0;double Lots_165 = 0;double Lots_166 = 0;double Lots_167 = 0;double Lots_168 = 0;double Lots_169 = 0;double Lots_170 = 0;double Lots_171 = 0;double Lots_172 = 0;double Lots_173 = 0;double Lots_174 = 0;double Lots_175 = 0;double Lots_176 = 0;double Lots_177 = 0;double Lots_178 = 0;double Lots_179 = 0;double Lots_180 = 0;double Lots_181 = 0;double Lots_182 = 0;double Lots_183 = 0;double Lots_184 = 0;double Lots_185 = 0;double Lots_186 = 0;double Lots_187 = 0;double Lots_188 = 0;double Lots_189 = 0;double Lots_190 = 0;double Lots_191 = 0;double Lots_192 = 0;double Lots_193 = 0;double Lots_194 = 0;double Lots_195 = 0;double Lots_196 = 0;double Lots_197 = 0;double Lots_198 = 0;double Lots_199 = 0;double Lots_200 = 0;double Lots_201 = 0;
double RTT_00 = 0;double RTT_01 = 0;double RTT_02 = 0;double RTT_03 = 0;double RTT_04 = 0;double RTT_05 = 0;double RTT_06 = 0;double RTT_07 = 0;double RTT_08 = 0;double RTT_09 = 0;double RTT_10 = 0;double RTT_11 = 0;double RTT_12 = 0;double RTT_13 = 0;double RTT_14 = 0;double RTT_15 = 0;double RTT_16 = 0;double RTT_17 = 0;double RTT_18 = 0;double RTT_19 = 0;double RTT_20 = 0;double RTT_21 = 0;double RTT_22 = 0;double RTT_23 = 0;double RTT_24 = 0;double RTT_25 = 0;double RTT_26 = 0;double RTT_27 = 0;double RTT_28 = 0;double RTT_29 = 0;double RTT_30 = 0;double RTT_31 = 0;double RTT_32 = 0;double RTT_33 = 0;double RTT_34 = 0;double RTT_35 = 0;double RTT_36 = 0;double RTT_37 = 0;double RTT_38 = 0;double RTT_39 = 0;double RTT_40 = 0;double RTT_41 = 0;double RTT_42 = 0;double RTT_43 = 0;double RTT_44 = 0;double RTT_45 = 0;double RTT_46 = 0;double RTT_47 = 0;double RTT_48 = 0;double RTT_49 = 0;double RTT_50 = 0;double RTT_51 = 0;double RTT_52 = 0;double RTT_53 = 0;double RTT_54 = 0;double RTT_55 = 0;double RTT_56 = 0;double RTT_57 = 0;double RTT_58 = 0;double RTT_59 = 0;double RTT_60 = 0;double RTT_61 = 0;double RTT_62 = 0;double RTT_63 = 0;double RTT_64 = 0;double RTT_65 = 0;double RTT_66 = 0;double RTT_67 = 0;double RTT_68 = 0;double RTT_69 = 0;double RTT_70 = 0;double RTT_71 = 0;double RTT_72 = 0;double RTT_73 = 0;double RTT_74 = 0;double RTT_75 = 0;double RTT_76 = 0;double RTT_77 = 0;double RTT_78 = 0;double RTT_79 = 0;double RTT_80 = 0;double RTT_81 = 0;double RTT_82 = 0;double RTT_83 = 0;double RTT_84 = 0;double RTT_85 = 0;double RTT_86 = 0;double RTT_87 = 0;double RTT_88 = 0;double RTT_89 = 0;double RTT_90 = 0;double RTT_91 = 0;double RTT_92 = 0;double RTT_93 = 0;double RTT_94 = 0;double RTT_95 = 0;double RTT_96 = 0;double RTT_97 = 0;double RTT_98 = 0;double RTT_99 = 0;double RTT_100 = 0;double RTT_101 = 0;double RTT_102 = 0;double RTT_103 = 0;double RTT_104 = 0;double RTT_105 = 0;double RTT_106 = 0;double RTT_107 = 0;double RTT_108 = 0;double RTT_109 = 0;double RTT_110 = 0;double RTT_111 = 0;double RTT_112 = 0;double RTT_113 = 0;double RTT_114 = 0;double RTT_115 = 0;double RTT_116 = 0;double RTT_117 = 0;double RTT_118 = 0;double RTT_119 = 0;double RTT_120 = 0;double RTT_121 = 0;double RTT_122 = 0;double RTT_123 = 0;double RTT_124 = 0;double RTT_125 = 0;double RTT_126 = 0;double RTT_127 = 0;double RTT_128 = 0;double RTT_129 = 0;double RTT_130 = 0;double RTT_131 = 0;double RTT_132 = 0;double RTT_133 = 0;double RTT_134 = 0;double RTT_135 = 0;double RTT_136 = 0;double RTT_137 = 0;double RTT_138 = 0;double RTT_139 = 0;double RTT_140 = 0;double RTT_141 = 0;double RTT_142 = 0;double RTT_143 = 0;double RTT_144 = 0;double RTT_145 = 0;double RTT_146 = 0;double RTT_147 = 0;double RTT_148 = 0;double RTT_149 = 0;double RTT_150 = 0;double RTT_151 = 0;double RTT_152 = 0;double RTT_153 = 0;double RTT_154 = 0;double RTT_155 = 0;double RTT_156 = 0;double RTT_157 = 0;double RTT_158 = 0;double RTT_159 = 0;double RTT_160 = 0;double RTT_161 = 0;double RTT_162 = 0;double RTT_163 = 0;double RTT_164 = 0;double RTT_165 = 0;double RTT_166 = 0;double RTT_167 = 0;double RTT_168 = 0;double RTT_169 = 0;double RTT_170 = 0;double RTT_171 = 0;double RTT_172 = 0;double RTT_173 = 0;double RTT_174 = 0;double RTT_175 = 0;double RTT_176 = 0;double RTT_177 = 0;double RTT_178 = 0;double RTT_179 = 0;double RTT_180 = 0;double RTT_181 = 0;double RTT_182 = 0;double RTT_183 = 0;double RTT_184 = 0;double RTT_185 = 0;double RTT_186 = 0;double RTT_187 = 0;double RTT_188 = 0;double RTT_189 = 0;double RTT_190 = 0;double RTT_191 = 0;double RTT_192 = 0;double RTT_193 = 0;double RTT_194 = 0;double RTT_195 = 0;double RTT_196 = 0;double RTT_197 = 0;double RTT_198 = 0;double RTT_199 = 0;double RTT_200 = 0;double RTT_201 = 0;
double BalUse_00 = 0;double BalUse_01 = 0;double BalUse_02 = 0;double BalUse_03 = 0;double BalUse_04 = 0;double BalUse_05 = 0;double BalUse_06 = 0;double BalUse_07 = 0;double BalUse_08 = 0;double BalUse_09 = 0;double BalUse_10 = 0;double BalUse_11 = 0;double BalUse_12 = 0;double BalUse_13 = 0;double BalUse_14 = 0;double BalUse_15 = 0;double BalUse_16 = 0;double BalUse_17 = 0;double BalUse_18 = 0;double BalUse_19 = 0;double BalUse_20 = 0;double BalUse_21 = 0;double BalUse_22 = 0;double BalUse_23 = 0;double BalUse_24 = 0;double BalUse_25 = 0;double BalUse_26 = 0;double BalUse_27 = 0;double BalUse_28 = 0;double BalUse_29 = 0;double BalUse_30 = 0;double BalUse_31 = 0;double BalUse_32 = 0;double BalUse_33 = 0;double BalUse_34 = 0;double BalUse_35 = 0;double BalUse_36 = 0;double BalUse_37 = 0;double BalUse_38 = 0;double BalUse_39 = 0;double BalUse_40 = 0;double BalUse_41 = 0;double BalUse_42 = 0;double BalUse_43 = 0;double BalUse_44 = 0;double BalUse_45 = 0;double BalUse_46 = 0;double BalUse_47 = 0;double BalUse_48 = 0;double BalUse_49 = 0;double BalUse_50 = 0;double BalUse_51 = 0;double BalUse_52 = 0;double BalUse_53 = 0;double BalUse_54 = 0;double BalUse_55 = 0;double BalUse_56 = 0;double BalUse_57 = 0;double BalUse_58 = 0;double BalUse_59 = 0;double BalUse_60 = 0;double BalUse_61 = 0;double BalUse_62 = 0;double BalUse_63 = 0;double BalUse_64 = 0;double BalUse_65 = 0;double BalUse_66 = 0;double BalUse_67 = 0;double BalUse_68 = 0;double BalUse_69 = 0;double BalUse_70 = 0;double BalUse_71 = 0;double BalUse_72 = 0;double BalUse_73 = 0;double BalUse_74 = 0;double BalUse_75 = 0;double BalUse_76 = 0;double BalUse_77 = 0;double BalUse_78 = 0;double BalUse_79 = 0;double BalUse_80 = 0;double BalUse_81 = 0;double BalUse_82 = 0;double BalUse_83 = 0;double BalUse_84 = 0;double BalUse_85 = 0;double BalUse_86 = 0;double BalUse_87 = 0;double BalUse_88 = 0;double BalUse_89 = 0;double BalUse_90 = 0;double BalUse_91 = 0;double BalUse_92 = 0;double BalUse_93 = 0;double BalUse_94 = 0;double BalUse_95 = 0;double BalUse_96 = 0;double BalUse_97 = 0;double BalUse_98 = 0;double BalUse_99 = 0;double BalUse_100 = 0;double BalUse_101 = 0;double BalUse_102 = 0;double BalUse_103 = 0;double BalUse_104 = 0;double BalUse_105 = 0;double BalUse_106 = 0;double BalUse_107 = 0;double BalUse_108 = 0;double BalUse_109 = 0;double BalUse_110 = 0;double BalUse_111 = 0;double BalUse_112 = 0;double BalUse_113 = 0;double BalUse_114 = 0;double BalUse_115 = 0;double BalUse_116 = 0;double BalUse_117 = 0;double BalUse_118 = 0;double BalUse_119 = 0;double BalUse_120 = 0;double BalUse_121 = 0;double BalUse_122 = 0;double BalUse_123 = 0;double BalUse_124 = 0;double BalUse_125 = 0;double BalUse_126 = 0;double BalUse_127 = 0;double BalUse_128 = 0;double BalUse_129 = 0;double BalUse_130 = 0;double BalUse_131 = 0;double BalUse_132 = 0;double BalUse_133 = 0;double BalUse_134 = 0;double BalUse_135 = 0;double BalUse_136 = 0;double BalUse_137 = 0;double BalUse_138 = 0;double BalUse_139 = 0;double BalUse_140 = 0;double BalUse_141 = 0;double BalUse_142 = 0;double BalUse_143 = 0;double BalUse_144 = 0;double BalUse_145 = 0;double BalUse_146 = 0;double BalUse_147 = 0;double BalUse_148 = 0;double BalUse_149 = 0;double BalUse_150 = 0;double BalUse_151 = 0;double BalUse_152 = 0;double BalUse_153 = 0;double BalUse_154 = 0;double BalUse_155 = 0;double BalUse_156 = 0;double BalUse_157 = 0;double BalUse_158 = 0;double BalUse_159 = 0;double BalUse_160 = 0;double BalUse_161 = 0;double BalUse_162 = 0;double BalUse_163 = 0;double BalUse_164 = 0;double BalUse_165 = 0;double BalUse_166 = 0;double BalUse_167 = 0;double BalUse_168 = 0;double BalUse_169 = 0;double BalUse_170 = 0;double BalUse_171 = 0;double BalUse_172 = 0;double BalUse_173 = 0;double BalUse_174 = 0;double BalUse_175 = 0;double BalUse_176 = 0;double BalUse_177 = 0;double BalUse_178 = 0;double BalUse_179 = 0;double BalUse_180 = 0;double BalUse_181 = 0;double BalUse_182 = 0;double BalUse_183 = 0;double BalUse_184 = 0;double BalUse_185 = 0;double BalUse_186 = 0;double BalUse_187 = 0;double BalUse_188 = 0;double BalUse_189 = 0;double BalUse_190 = 0;double BalUse_191 = 0;double BalUse_192 = 0;double BalUse_193 = 0;double BalUse_194 = 0;double BalUse_195 = 0;double BalUse_196 = 0;double BalUse_197 = 0;double BalUse_198 = 0;double BalUse_199 = 0;double BalUse_200 = 0;double BalUse_201 = 0;
double Sum_Balance = 0;

double firstOpenBuyPrice = 0.0;
double firstOpenSellPrice = 0.0;

// GLOBAL DESCRIPTIONS FOR EA
double Mpx=0;
double My_Multiple_Lots=0;
int TotalOrder;
double BuyTerbawah;
double SellTeratas;
double BuyTeratas;
double SellTerbawah;

int MaxTrades=0;
bool UseMartiLayer = FALSE;
 double     GroupLayer  = NumLines;        // Group Layer
double  MultiLayer  = 1.0;      // Pengali Layer
double CurrentEquity=0;
double LastEquity=0;

int tiket=0;

int counter=0;
double MartiLot,MartiLotFT;
bool UseTrailing=FALSE;
   double close_cs2;
   double close_cs1;
   double BidPrice;
double AskPrice;
int TimerOrders;
 int MaxTradeOpenHours = 48.0;
/*enum str_TP{UseTP_All, // Trade Close All
             UseTP_Partial, // Trade Close Partial

      };
input  str_TP     TradeClose   = 0;        // Trade Close [TP]*/
double T_Harian=0;
bool play = 1, stop = 0;       
int time_Bal=0;       
bool timer=false;
double balanc=0;
double price_BEP;
double TrailingPrice_Stoploss = 0.0;
double TrailingPrice_Profit=0;

 double Stoploss = 00.0;
bool UseModifyTrailing=FALSE;
double str_price_tp_buy=0;
double str_price_tp_sell=0;
 bool UseTrailingStop = FALSE;
 bool UseTimeOut = FALSE;
 double TrailStart = 200.0;
 double TrailStop = 200.0;
int time_current = 0;
 bool UseEquityStop = FALSE;
 double TotalEquityRisk = 20.0;
 extern bool    BreakOrder  = 0;        // Stop Order Awal?
int order_buy=0;int order_sell=0;
int counter0=0;int counter1=0;
double MartiBuy=0;double MartiSell=0;
double MartiLot_Buy=0;double MartiLot_Sell=0;
string text="";string alert;
double LastHighestLots=0;
enum str_TP{UseTP_All_Percent, // Trade Close All by Percent
            UseTP_Partial_Percent, // Trade Close Partial by Percent
            UseTP_Money, // Trade Close by Dollar Target
      };
extern str_TP     TradeClose_TP   = 0;        // Trade Close TP

enum str_SL{UseSL_Risk, // Trade Close SL by Risk
            UseSL_Clear, // Trade Close SL Clear
      };
extern str_SL     TradeClose_SL   = 0;        // Trade Close SL

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
    Comment("");   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  { Comment("");   ObjectDelete(alert);
//--- 
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
     
   //  if (OrdersTotal()>0)SetTarget();
     Martilot(1);Martilot(0);RangeStep(0);RangeStep(1);
    
     
     
//@-------/---------setalert  
// SCRIPT PROTEKSI   
   if(Lock_By_Password==1 && Lock_Password != Password) {
   Alert("Wrong Password");
      Alertz("LockInfo","Wrong Password");
   return;
   }

    if(Lock_By_DateTime==1 && (TimeCurrent() > dtExpired || TimeLocal() > dtExpired)) {
      Alert("System Expired");
      Alertz("LockInfo","System Expired");
      return;      
   }

// Note:===> (TimeCurrent() < dtExpired || TimeLocal() < dtExpired)

   if(Lock_By_Number ==1&& AccountNumber() != Lock_Number) {
      Alert("Account Number Not Licenced");
      Alertz("LockInfo","Account Number Not Licenced");
      return;      
   }

// Note: ===> AccountNumber() == Lock_Number

   if(Lock_By_Name ==1&& AccountName() != Lock_Name) {
      Alert("Account Name Not Licenced");
      Alertz("LockInfo","Account Name Not Licenced");
      return;      
   }   
// Note:===> AccountName() == Lock_Name      

//----Set Lock
//   if ( (Jam_trade()==1 ) && ((DayOfWeek()!=0)||(DayOfWeek()!=6))){
//   if (Lock_Password==Password){
   if (Lock_By_DateTime==1 && (TimeCurrent() < dtExpired || TimeLocal() < dtExpired)){
//   if (Lock_By_Number==1 && AccountNumber() == Lock_Number){
//   if (Lock_By_Name==1 && AccountName() == Lock_Name){
//   if ((Lock_By_Number==1 && AccountNumber() == Lock_Number)||(Lock_By_Name==1 && AccountName() == Lock_Name)||(Lock_By_Password==1 && Lock_Password==Password)||(Lock_By_DateTime==1 && (TimeCurrent() < dtExpired || TimeLocal() < dtExpired))){

    
     SetOrders();
     
     if(Minute()>=0 && Minute()<=5)timer=true;
      if(Minute()>=6 && Minute()<=14)timer=false;
     if(Minute()>=15 && Minute()<=20)timer=true;
      if(Minute()>=21 && Minute()<=29)timer=false;
     if(Minute()>=30 && Minute()<=35)timer=true;
      if(Minute()>=36 && Minute()<=44)timer=false;
     if(Minute()>=45 && Minute()<=50)timer=true;
      if(Minute()>=51 && Minute()<=59)timer=false;
      
     //if(TradeClose_TP==0 ){Set_TP_Partial_Percent_Buy();Set_TP_Partial_Percent_Sell();}
     if(TradeClose_TP==1 && timer==true){Set_TP_Partial_Percent_Buy();Set_TP_Partial_Percent_Sell();}
     if(TradeClose_TP==2 && timer==true){Set_TP_Dollar_Buy();Set_TP_Dollar_Sell();}
     
     if(TradeClose_SL==0 && timer==true){Set_SL_Buy();Set_SL_Sell();}
     if(TradeClose_SL==1 && timer==true){Set_SL_Clear_Buy();Set_SL_Clear_Sell();}
    if(ShowInfo && !IsTradeContextBusy()){ DISPLAY();}
     ResetLastError();
     }//
     return;
  }
//+------------------------------------------------------------------+

void SetOrders()
{

   order_buy = Post(0);   
   order_sell = Post(1);
   counter0 = (order_buy+1);
   counter1 = (order_sell+1);
   HargaMarti(); 
   
   MartiLot_Buy  = Martilot(0);
   MartiLot_Sell  = Martilot(1);
   MartiBuy  = BuyTerbawah-MartiLayer(0)*Point; 
   MartiSell = SellTeratas+MartiLayer(1)*Point;
   
 if(order_buy+order_sell==0) tiket=0;
  // if(IsTradeAllowed () && !IsTradeContextBusy()){ //{
   if( Ask <= MartiBuy && order_buy > 0 && order_buy <= NumLines && order_buy <= MaxOrder  && !BreakMartiBuy) //{
//       tiket = OrderSend(Symbol(),0,NormalizeDouble(Martilot(),2),Ask,slip,0,0,comment+IntegerToString(counter0));
            tiket = OpenOrder(0, MartiLot_Buy, Ask, slip, Bid, 0, 0, NamaEA + "-" + IntegerToString(Magic )+" PasopatiFx-"+IntegerToString(counter0), Magic, 0, Lime);
            /*if (tiket < 0) {
               Print("Error: ", GetLastError());ResetLastError();
               
            }
       if(tiket>0)Print("MartiBuy GandewaFx :"+IntegerToString(Magic)+" Lot:"+DoubleToStr(Martilot(0),lotDigit())+" PasopatiFx-"+IntegerToString(Magic));

       }*/
  if( Bid >= MartiSell && order_sell > 0 && order_sell <= NumLines && order_sell <= MaxOrder  && !BreakMartiSell)// {
//       tiket = OrderSend(Symbol(),1,NormalizeDouble(Martilot(),2),Bid,slip,0,0,comment+IntegerToString(counter1)); 
         tiket = OpenOrder(1, MartiLot_Sell, Bid, slip, Ask, 0, 0, NamaEA + "-" + IntegerToString(Magic)+" PasopatiFx-"+IntegerToString(counter1), Magic, 0, HotPink);
       /*  if (tiket < 0) {
            Print("Error: ", GetLastError());ResetLastError();
            
         }
      if(tiket>0) Print("MartiSell GandewaFx :"+IntegerToString(Magic)+" Lot:"+DoubleToStr(Martilot(1),2)+" PasopatiFx-"+IntegerToString(counter1));

       }*/
    // }
//else
   if(!IsTradeContextBusy() && !stop && play && ((order_buy+order_sell == 0))  && !BreakOrder)// {
   {   if(  order_buy ==0 && UseBuy) //tiket = OrderSend(Symbol(),0,Martilot(),Ask,slip,0,0,comment+IntegerToString(counter0)); 
      tiket = OpenOrder(0, 0.01, AskPrice, slip, AskPrice, 0, 0, NamaEA + "-" + NamaEA +IntegerToString(Magic)+" PasopatiFx-"+IntegerToString(counter0), Magic, 0, Lime);
              /* if (tiket < 0) {
                  Print("Error: ", GetLastError());ResetLastError();
                  
               }
      if(tiket>0 && order_buy==1) Print("Buy GandewaFx:"+IntegerToString(Magic)+" Lot:"+DoubleToStr(Martilot(0),2)+" PasopatiFx-"+IntegerToString(counter0));
  */
    //else
      if(  order_sell==0 && UseSell)// tiket = OrderSend(Symbol(),1,Martilot(),Bid,slip,0,0,comment+IntegerToString(counter1)); 
       tiket = OpenOrder(1, 0.01, BidPrice, slip, BidPrice, 0, 0, NamaEA + "-" + NamaEA +IntegerToString(Magic)+" PasopatiFx-"+IntegerToString(counter1), Magic, 0, HotPink);
           /*    if (tiket < 0) {
                  Print("Error: ", GetLastError());ResetLastError();
                  
               }
      if(tiket>0 && order_sell==1)Print("Sell GandewaFx:"+IntegerToString(Magic)+" Lot:"+DoubleToStr(Martilot(1),2)+" PasopatiFx-"+IntegerToString(counter1));
              
}*/}
/*else
 if(!IsTradeContextBusy() &&(( Ask >= MartiBuy )||( Bid <= MartiSell))  && (order_buy > 0 || order_sell>0) ) {
//    */ 
  SetTarget();
          /*  }*/

return;
}


void SetTarget()
{
Target();

//Target Akumulasi By MagicNumber
   if(TradeClose_TP==0 && NormalizeDouble(DailyTarget_,2) > 0 && NormalizeDouble(DailyReturns(),2) >= NormalizeDouble(T_Harian ,2)&& (Post(1)+Post(0))>=0 ) {
      CloseThisSymbolAll();
      play = 0; 
      Alertz("DailyTarget","Daily Target's Reached, EA BREAK");
 
   }
   
   
//Target Akumulasi By MagicNumber Buy
   if(TradeClose_TP==1 && Post(0)>=0 && NormalizeDouble(DailyTarget_,2) > 0 && NormalizeDouble(DailyReturn(0),2) >= NormalizeDouble(T_Harian ,2) ) {
      CloseThisSymbolAll_Buy();
      play = 0; 
      Alertz("DailyTarget","Daily Target Part Buy Reached, EA BREAK");
 
   }
   
   //Target Akumulasi By MagicNumber Sell
   if(TradeClose_TP==1 && Post(1)>=0 && NormalizeDouble(DailyTarget_,2) > 0 && NormalizeDouble(DailyReturn(1),2) >= NormalizeDouble(T_Harian ,2) ) {
      CloseThisSymbolAll_Sell();
      play = 0; 
      Alertz("DailyTarget","Daily Target Part Sell Reached, EA BREAK");
 
   }
   
   //Target Akumulasi By History Orders And Open Orders when Open Orders exist
   if (CalculateTotalProfit()>NormalizeDouble(T_Harian,2)) 
    {
    CloseThisSymbolAll();
    play = 0;
    Alertz("DailyTarget","Daily Target From History Reached, EA BREAK");
 
    }

   if(Risk > 0 && ((AccountBalance() - AccountEquity())/ AccountBalance()) * 100 >= Risk ) {
      CloseThisSymbolAll(); 
      stop = 1; 
      Alertz("RiskTarget","Risk Target Reached, EA STOP");
      }



return;
}

int Post( int tipe) {
   int total=0;
   for(int i=0; i<OrdersTotal(); i++) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic && OrderType()==tipe)
        total++;
      }
     }
   return(total);
   }

// Expert Advisor to Print Prices 10000 Points Below the First Open Buy Order Price



double Price_MC_Buy()
{ double price=0;
    // Check for the first open buy order and store its price
    if (firstOpenBuyPrice == 0.0)
    {
        for (int i = OrdersTotal() - 1; i >= 0; i--)
        {
            if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
            {
                if (OrderSymbol() == Symbol() && OrderType() == OP_BUY && OrderMagicNumber() == Magic)
                {
                    firstOpenBuyPrice = OrderOpenPrice();
                    break;
                }
            }
        }
    }

    // Print prices 10000 points below the first open buy order price
    if (firstOpenBuyPrice != 0.0)
    {
        for (int i = 0; i < 11; i++)
        {
             price = NormalizeDouble(firstOpenBuyPrice-(i*NumLines*RangeStep(0)*Point), Digits);
            
            //Print("Price MC Buy", ": ", price);
        }
    }return price;
}

double Price_MC_Sell()
{ double price = 0;
    // Check for the first open Sell order and store its price
    if (firstOpenSellPrice == 0.0)
    {
        for (int i = OrdersTotal() - 1; i >= 0; i--)
        {
            if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
            {
                if (OrderSymbol() == Symbol() && OrderType() == OP_SELL && OrderMagicNumber() == Magic)
                {
                    firstOpenSellPrice = OrderOpenPrice();
                    break;
                }
            }
        }
    }

    // Print prices 10000 points below the first open Sell order price
    if (firstOpenSellPrice != 0.0)
    {
        for (int i = 0; i < 11; i++)
        {
             price = NormalizeDouble(firstOpenSellPrice + (i*NumLines*RangeStep(1)*Point), Digits);
           // Print("Price MC Sell", ": ", price);
        }
    }return price;
}

// Expert Advisor to Count Profit from Open and History Orders
datetime CalculateTimeFirstOpenOrders()
{
    datetime timeFirstOpenOrders = 0.0;
    datetime timeFirstOpen = 0.0;
    // Calculate profit from open orders
    for (int i = OrdersTotal() - 1; i >= 0; i--)
    {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic )
            {
            if(i<3) timeFirstOpenOrders = OrderOpenTime();
             timeFirstOpen = timeFirstOpenOrders; 
            // if(timeFirstOpen>OrderOpenTime()) timeFirstOpen = ;
            }
        }
    }
return timeFirstOpen;
}



double CalculateTotalProfit()
{
    double totalProfit = 0;
    double  totalProfitOpenOrders=0;
    double  totalProfitHistoryOrders=0;
    datetime dtOP = 0;
    
    if ( OrdersTotal()>0){
     for (int i = OrdersTotal() - 1; i >= 0; i--)
    {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic)
            {
            
            totalProfitOpenOrders += OrderProfit();
            dtOP = OrderOpenTime();
            }}}
           //datetime dtop = dtOP;
           
             for (int j = OrdersHistoryTotal() - 1; j >= 0; j--)
        {
            if (OrderSelect(j, SELECT_BY_POS, MODE_HISTORY))
            {
  if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic 
      && dtOP < OrderCloseTime()
   ){
 
           
          // if(CalculateTimeFirstOpenOrders() > OrderOpenTime() )
               totalProfitHistoryOrders += OrderProfit();
         
         
         }}}   
             
        totalProfit =   totalProfitHistoryOrders + totalProfitOpenOrders ;
        //+ CalculateTotalProfitOpenOrders();
        //DailyReturns();
    //    Print("Total Profit from Open and History Orders: ", totalProfit);
   
  }
   
   
   else
    {
        totalProfit = 0;
     //    Print("No open orders in trading history.");
    }
    return totalProfit;
}



int ordertiket_buy( int c) {
   int i=0,
   tc_0 =0, 
   tc_1 =0,
   tc_2=0,
   tc_3=0,
   tc_4=0,
   tc_5=0,
   tc_6=0,
   tc_7 =0,
   tc_8 =0,
   tc_9 =0,
   tc_10 =0,
   tc_11 =0,
   tc_12 =0,
   tc_13 =0,
   tc_14 =0,
   tc_15 =0,
   tc_16 =0,
   tc_17 =0,
   tc_18 =0,
   tc_19 =0,
   tc_20 =0,
   tc_21 =0,
   tc_22 =0,
   tc_23 =0,
   tc_24 =0,
   tc_25 =0,
   tc_26 =0,
   tc_27 =0,
   tc_28 =0,
   tc_29 =0,
   tc_30 =0,
   tc_31 =0,
   tc_32 =0,
   tc_33 =0,
   tc_34 =0,
   tc_35 =0,
   tc_36 =0,
   tc_37 =0,
   tc_38 =0,
   tc_39 =0,
   tc_40 =0,
   tc_41 =0,
   tc_42 =0,
   tc_43 =0,
   tc_44 =0,
   tc_45 =0,
   tc_46 =0,
   tc_47 =0,
   tc_48 =0,
   tc_49 =0,
   tc_50 =0,
   tc_51 =0,
   tc_52 =0,
   tc_53 =0,
   tc_54 =0,
   tc_55 =0,
   tc_56 =0,
   tc_57 =0,
   tc_58 =0,
   tc_59 =0,
   tc_60 =0,
   tc_61 =0,
   tc_62 =0,
   tc_63 =0,
   tc_64 =0,
   tc_65 =0,
   tc_66 =0,
   tc_67 =0,
   tc_68 =0,
   tc_69 =0,
   tc_70 =0,
   tc_71 =0,
   tc_72 =0,
   tc_73 =0,
   tc_74 =0,
   tc_75 =0,
   tc_76 =0,
   tc_77 =0,
   tc_78 =0,
   tc_79 =0,
   tc_80 =0,
   tc_81 =0,
   tc_82 =0,
   tc_83 =0,
   tc_84 =0,
   tc_85 =0,
   tc_86 =0,
   tc_87 =0,
   tc_88 =0,
   tc_89 =0,
   tc_90 =0,
   tc_91 =0,
   tc_92 =0,
   tc_93 =0,
   tc_94 =0,
   tc_95 =0,
   tc_96 =0,
   tc_97 =0,
   tc_98 =0,
   tc_99 =0,
   tc_100 =0,
   tc_101 =0,
   to =0;
   
    
     for(int j=0; j<OrdersTotal(); j++) {
         if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic && OrderType()==0){
         i++;
         if(i==0  ) tc_0= OrderTicket();
         if(i==1  ) tc_1= OrderTicket();
         if(i==2  ) tc_2= OrderTicket();
         if(i==3  ) tc_3= OrderTicket();
         if(i==4  ) tc_4= OrderTicket();
         if(i==5  ) tc_5= OrderTicket();
         if(i==6  ) tc_6= OrderTicket();
         if(i==7  ) tc_7= OrderTicket();
         if(i==8  ) tc_8= OrderTicket();
         if(i==9  ) tc_9= OrderTicket();
         if(i==10 ) tc_10= OrderTicket();
         if(i==11  ) tc_11= OrderTicket();
         if(i==12  ) tc_12= OrderTicket();
         if(i==13  ) tc_13= OrderTicket();
         if(i==14  ) tc_14= OrderTicket();
         if(i==15  ) tc_15= OrderTicket();
         if(i==16  ) tc_16= OrderTicket();
         if(i==17  ) tc_17= OrderTicket();
         if(i==18  ) tc_18= OrderTicket();
         if(i==19  ) tc_19= OrderTicket();
         if(i==20  ) tc_20= OrderTicket();
         if(i==21  ) tc_21= OrderTicket();
         if(i==22  ) tc_22= OrderTicket();
         if(i==23  ) tc_23= OrderTicket();
         if(i==24  ) tc_24= OrderTicket();
         if(i==25  ) tc_25= OrderTicket();
         if(i==26  ) tc_26= OrderTicket();
         if(i==27  ) tc_27= OrderTicket();
         if(i==28  ) tc_28= OrderTicket();
         if(i==29  ) tc_29= OrderTicket();
         if(i==30  ) tc_30= OrderTicket();
         if(i==31  ) tc_31= OrderTicket();
         if(i==32  ) tc_32= OrderTicket();
         if(i==33  ) tc_33= OrderTicket();
         if(i==34  ) tc_34= OrderTicket();
         if(i==35  ) tc_35= OrderTicket();
         if(i==36  ) tc_36= OrderTicket();
         if(i==37  ) tc_37= OrderTicket();
         if(i==38  ) tc_38= OrderTicket();
         if(i==39  ) tc_39= OrderTicket();
         if(i==40  ) tc_40= OrderTicket();
         if(i==41  ) tc_41= OrderTicket();
         if(i==42  ) tc_42= OrderTicket();
         if(i==43  ) tc_43= OrderTicket();
         if(i==44  ) tc_44= OrderTicket();
         if(i==45  ) tc_45= OrderTicket();
         if(i==46  ) tc_46= OrderTicket();
         if(i==47  ) tc_47= OrderTicket();
         if(i==48  ) tc_48= OrderTicket();
         if(i==49  ) tc_49= OrderTicket();
         if(i==50  ) tc_50= OrderTicket();
         if(i==51  ) tc_51= OrderTicket();
         if(i==52  ) tc_52= OrderTicket();
         if(i==53  ) tc_53= OrderTicket();
         if(i==54  ) tc_54= OrderTicket();
         if(i==55  ) tc_55= OrderTicket();
         if(i==56  ) tc_56= OrderTicket();
         if(i==57  ) tc_57= OrderTicket();
         if(i==58  ) tc_58= OrderTicket();
         if(i==59  ) tc_59= OrderTicket();
         if(i==60  ) tc_60= OrderTicket();
         if(i==61  ) tc_61= OrderTicket();
         if(i==62  ) tc_62= OrderTicket();
         if(i==63  ) tc_63= OrderTicket();
         if(i==64  ) tc_64= OrderTicket();
         if(i==65  ) tc_65= OrderTicket();
         if(i==66  ) tc_66= OrderTicket();
         if(i==67  ) tc_67= OrderTicket();
         if(i==68  ) tc_68= OrderTicket();
         if(i==69  ) tc_69= OrderTicket();
         if(i==70  ) tc_70= OrderTicket();
         if(i==71  ) tc_71= OrderTicket();
         if(i==72  ) tc_72= OrderTicket();
         if(i==73  ) tc_73= OrderTicket();
         if(i==74 ) tc_74= OrderTicket();
         if(i==75 ) tc_75= OrderTicket();
         if(i==76  ) tc_76= OrderTicket();
         if(i==77  ) tc_77= OrderTicket();
         if(i==78 ) tc_78= OrderTicket();
         if(i==79  ) tc_79= OrderTicket();
         if(i==80  ) tc_80= OrderTicket();
         if(i==81 ) tc_81= OrderTicket();
         if(i==82  ) tc_82= OrderTicket();
         if(i==83  ) tc_83= OrderTicket();
         if(i==84  ) tc_84= OrderTicket();
         if(i==85  ) tc_85= OrderTicket();
         if(i==86  ) tc_86= OrderTicket();
         if(i==87  ) tc_87= OrderTicket();
         if(i==88 ) tc_88= OrderTicket();
         if(i==89 ) tc_89= OrderTicket();
         if(i==90  ) tc_90= OrderTicket();
         if(i==91  ) tc_91= OrderTicket();
         if(i==92  ) tc_92= OrderTicket();
         if(i==93  ) tc_93= OrderTicket();
         if(i==94  ) tc_94= OrderTicket();
         if(i==95  ) tc_95= OrderTicket();
         if(i==96 ) tc_96= OrderTicket();
         if(i==97  ) tc_97= OrderTicket();
         if(i==98  ) tc_98= OrderTicket();
         if(i==99  ) tc_99= OrderTicket();
         if(i==100  ) tc_100= OrderTicket();
         if(i==101  ) tc_101= OrderTicket(); 

         
      
      
         if(c==0) to=tc_0;     
         if(c==1) to=tc_1;
         if(c==2) to=tc_2;
         if(c==3) to=tc_3;
         if(c==4) to=tc_4;
         if(c==5) to=tc_5;
         if(c==6) to=tc_6;
         if(c==7) to=tc_7;
         if(c==8) to=tc_8;
         if(c==9) to=tc_9;
         if(c==10) to=tc_10;
         if(c==11) to=tc_11;
         if(c==12) to=tc_12;
         if(c==13) to=tc_13;
         if(c==14) to=tc_14;
         if(c==15) to=tc_15;
         if(c==16) to=tc_16;
         if(c==17) to=tc_17;
         if(c==18) to=tc_18;
         if(c==19) to=tc_19;
         if(c==20) to=tc_20;
         if(c==21) to=tc_21;
         if(c==22) to=tc_22;
         if(c==23) to=tc_23;
         if(c==24) to=tc_24;
         if(c==25) to=tc_25;
         if(c==26) to=tc_26;
         if(c==27) to=tc_27;
         if(c==28) to=tc_28;
         if(c==29) to=tc_29;
         if(c==30) to=tc_30;
         if(c==31) to=tc_31;
         if(c==32) to=tc_32;
         if(c==33) to=tc_33;
         if(c==34) to=tc_34;
         if(c==35) to=tc_35;
         if(c==36) to=tc_36;
         if(c==37) to=tc_37;
         if(c==38) to=tc_38;
         if(c==39) to=tc_39;
         if(c==40) to=tc_40;
         if(c==41) to=tc_41;
         if(c==42) to=tc_42;
         if(c==43) to=tc_43;
         if(c==44) to=tc_44;
         if(c==45) to=tc_45;
         if(c==46) to=tc_46;
         if(c==47) to=tc_47;
         if(c==48) to=tc_48;
         if(c==49) to=tc_49;
         if(c==50) to=tc_50;
         if(c==51) to=tc_51;
         if(c==52) to=tc_52;
         if(c==53) to=tc_53;
         if(c==54) to=tc_54;
         if(c==55) to=tc_55;
         if(c==56) to=tc_56;
         if(c==57) to=tc_57;
         if(c==58) to=tc_58;
         if(c==59) to=tc_59;
         if(c==60) to=tc_60;
         if(c==61) to=tc_61;
         if(c==62) to=tc_62;
         if(c==63) to=tc_63;
         if(c==64) to=tc_64;
         if(c==65) to=tc_65;
         if(c==66) to=tc_66;
         if(c==67) to=tc_67;
         if(c==68) to=tc_68;
         if(c==69) to=tc_69;
         if(c==70) to=tc_70;
         if(c==71) to=tc_71;
         if(c==72) to=tc_72;
         if(c==73) to=tc_73;
         if(c==74) to=tc_74;
         if(c==75) to=tc_75;
         if(c==76) to=tc_76;
         if(c==77) to=tc_77;
         if(c==78) to=tc_78;
         if(c==79) to=tc_79;
         if(c==80) to=tc_80;
         if(c==81) to=tc_81;
         if(c==82) to=tc_82;
         if(c==83) to=tc_83;
         if(c==84) to=tc_84;
         if(c==85) to=tc_85;
         if(c==86) to=tc_86;
         if(c==87) to=tc_87;
         if(c==88) to=tc_88;
         if(c==89) to=tc_89;
         if(c==90) to=tc_90;
         if(c==91) to=tc_91;
         if(c==92) to=tc_92;
         if(c==93) to=tc_93;
         if(c==94) to=tc_94;
         if(c==95) to=tc_95;
         if(c==96) to=tc_96;
         if(c==97) to=tc_97;
         if(c==98) to=tc_98;
         if(c==99) to=tc_99;
         if(c==100) to=tc_100;
         if(c==101) to=tc_101;
         }}}
   return(to);
   }


double orderopenprice_buy( int c) {
   int i=0;
double
   op_0 =0, 
   op_1 =0,
   op_2=0,
   op_3=0,
   op_4=0,
   op_5=0,
   op_6=0,
   op_7 =0,
   op_8 =0,
   op_9 =0,
   op_10 =0,
   op_11 =0,
   op_12 =0,
   op_13 =0,
   op_14 =0,
   op_15 =0,
   op_16 =0,
   op_17 =0,
   op_18 =0,
   op_19 =0,
   op_20 =0,
   op_21 =0,
   op_22 =0,
   op_23 =0,
   op_24 =0,
   op_25 =0,
   op_26 =0,
   op_27 =0,
   op_28 =0,
   op_29 =0,
   op_30 =0,
   op_31 =0,
   op_32 =0,
   op_33 =0,
   op_34 =0,
   op_35 =0,
   op_36 =0,
   op_37 =0,
   op_38 =0,
   op_39 =0,
   op_40 =0,
   op_41 =0,
   op_42 =0,
   op_43 =0,
   op_44 =0,
   op_45 =0,
   op_46 =0,
   op_47 =0,
   op_48 =0,
   op_49 =0,
   op_50 =0,
   op_51 =0,
   op_52 =0,
   op_53 =0,
   op_54 =0,
   op_55 =0,
   op_56 =0,
   op_57 =0,
   op_58 =0,
   op_59 =0,
   op_60 =0,
   op_61 =0,
   op_62 =0,
   op_63 =0,
   op_64 =0,
   op_65 =0,
   op_66 =0,
   op_67 =0,
   op_68 =0,
   op_69 =0,
   op_70 =0,
   op_71 =0,
   op_72 =0,
   op_73 =0,
   op_74 =0,
   op_75 =0,
   op_76 =0,
   op_77 =0,
   op_78 =0,
   op_79 =0,
   op_80 =0,
   op_81 =0,
   op_82 =0,
   op_83 =0,
   op_84 =0,
   op_85 =0,
   op_86 =0,
   op_87 =0,
   op_88 =0,
   op_89 =0,
   op_90 =0,
   op_91 =0,
   op_92 =0,
   op_93 =0,
   op_94 =0,
   op_95 =0,
   op_96 =0,
   op_97 =0,
   op_98 =0,
   op_99 =0,
   op_100 =0,
   op_101 =0,
   to =0;
   
    
     for(int j=0; j<OrdersTotal(); j++) {
         if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic && OrderType()==0){
         i++;
         if(i==0  ) op_0= OrderOpenPrice();
         if(i==1  ) op_1= OrderOpenPrice();
         if(i==2  ) op_2= OrderOpenPrice();
         if(i==3  ) op_3= OrderOpenPrice();
         if(i==4  ) op_4= OrderOpenPrice();
         if(i==5  ) op_5= OrderOpenPrice();
         if(i==6  ) op_6= OrderOpenPrice();
         if(i==7  ) op_7= OrderOpenPrice();
         if(i==8  ) op_8= OrderOpenPrice();
         if(i==9  ) op_9= OrderOpenPrice();
         if(i==10 ) op_10= OrderOpenPrice();
         if(i==11  ) op_11= OrderOpenPrice();
         if(i==12  ) op_12= OrderOpenPrice();
         if(i==13  ) op_13= OrderOpenPrice();
         if(i==14  ) op_14= OrderOpenPrice();
         if(i==15  ) op_15= OrderOpenPrice();
         if(i==16  ) op_16= OrderOpenPrice();
         if(i==17  ) op_17= OrderOpenPrice();
         if(i==18  ) op_18= OrderOpenPrice();
         if(i==19  ) op_19= OrderOpenPrice();
         if(i==20  ) op_20= OrderOpenPrice();
         if(i==21  ) op_21= OrderOpenPrice();
         if(i==22  ) op_22= OrderOpenPrice();
         if(i==23  ) op_23= OrderOpenPrice();
         if(i==24  ) op_24= OrderOpenPrice();
         if(i==25  ) op_25= OrderOpenPrice();
         if(i==26  ) op_26= OrderOpenPrice();
         if(i==27  ) op_27= OrderOpenPrice();
         if(i==28  ) op_28= OrderOpenPrice();
         if(i==29  ) op_29= OrderOpenPrice();
         if(i==30  ) op_30= OrderOpenPrice();
         if(i==31  ) op_31= OrderOpenPrice();
         if(i==32  ) op_32= OrderOpenPrice();
         if(i==33  ) op_33= OrderOpenPrice();
         if(i==34  ) op_34= OrderOpenPrice();
         if(i==35  ) op_35= OrderOpenPrice();
         if(i==36  ) op_36= OrderOpenPrice();
         if(i==37  ) op_37= OrderOpenPrice();
         if(i==38  ) op_38= OrderOpenPrice();
         if(i==39  ) op_39= OrderOpenPrice();
         if(i==40  ) op_40= OrderOpenPrice();
         if(i==41  ) op_41= OrderOpenPrice();
         if(i==42  ) op_42= OrderOpenPrice();
         if(i==43  ) op_43= OrderOpenPrice();
         if(i==44  ) op_44= OrderOpenPrice();
         if(i==45  ) op_45= OrderOpenPrice();
         if(i==46  ) op_46= OrderOpenPrice();
         if(i==47  ) op_47= OrderOpenPrice();
         if(i==48  ) op_48= OrderOpenPrice();
         if(i==49  ) op_49= OrderOpenPrice();
         if(i==50  ) op_50= OrderOpenPrice();
         if(i==51  ) op_51= OrderOpenPrice();
         if(i==52  ) op_52= OrderOpenPrice();
         if(i==53  ) op_53= OrderOpenPrice();
         if(i==54  ) op_54= OrderOpenPrice();
         if(i==55  ) op_55= OrderOpenPrice();
         if(i==56  ) op_56= OrderOpenPrice();
         if(i==57  ) op_57= OrderOpenPrice();
         if(i==58  ) op_58= OrderOpenPrice();
         if(i==59  ) op_59= OrderOpenPrice();
         if(i==60  ) op_60= OrderOpenPrice();
         if(i==61  ) op_61= OrderOpenPrice();
         if(i==62  ) op_62= OrderOpenPrice();
         if(i==63  ) op_63= OrderOpenPrice();
         if(i==64  ) op_64= OrderOpenPrice();
         if(i==65  ) op_65= OrderOpenPrice();
         if(i==66  ) op_66= OrderOpenPrice();
         if(i==67  ) op_67= OrderOpenPrice();
         if(i==68  ) op_68= OrderOpenPrice();
         if(i==69  ) op_69= OrderOpenPrice();
         if(i==70  ) op_70= OrderOpenPrice();
         if(i==71  ) op_71= OrderOpenPrice();
         if(i==72  ) op_72= OrderOpenPrice();
         if(i==73  ) op_73= OrderOpenPrice();
         if(i==74 ) op_74= OrderOpenPrice();
         if(i==75 ) op_75= OrderOpenPrice();
         if(i==76  ) op_76= OrderOpenPrice();
         if(i==77  ) op_77= OrderOpenPrice();
         if(i==78 ) op_78= OrderOpenPrice();
         if(i==79  ) op_79= OrderOpenPrice();
         if(i==80  ) op_80= OrderOpenPrice();
         if(i==81 ) op_81= OrderOpenPrice();
         if(i==82  ) op_82= OrderOpenPrice();
         if(i==83  ) op_83= OrderOpenPrice();
         if(i==84  ) op_84= OrderOpenPrice();
         if(i==85  ) op_85= OrderOpenPrice();
         if(i==86  ) op_86= OrderOpenPrice();
         if(i==87  ) op_87= OrderOpenPrice();
         if(i==88 ) op_88= OrderOpenPrice();
         if(i==89 ) op_89= OrderOpenPrice();
         if(i==90  ) op_90= OrderOpenPrice();
         if(i==91  ) op_91= OrderOpenPrice();
         if(i==92  ) op_92= OrderOpenPrice();
         if(i==93  ) op_93= OrderOpenPrice();
         if(i==94  ) op_94= OrderOpenPrice();
         if(i==95  ) op_95= OrderOpenPrice();
         if(i==96 ) op_96= OrderOpenPrice();
         if(i==97  ) op_97= OrderOpenPrice();
         if(i==98  ) op_98= OrderOpenPrice();
         if(i==99  ) op_99= OrderOpenPrice();
         if(i==100  ) op_100= OrderOpenPrice();
         if(i==101  ) op_101= OrderOpenPrice();


         if(c==0) to=op_0;     
         if(c==1) to=op_1;
         if(c==2) to=op_2;
         if(c==3) to=op_3;
         if(c==4) to=op_4;
         if(c==5) to=op_5;
         if(c==6) to=op_6;
         if(c==7) to=op_7;
         if(c==8) to=op_8;
         if(c==9) to=op_9;
         if(c==10) to=op_10;
         if(c==11) to=op_11;
         if(c==12) to=op_12;
         if(c==13) to=op_13;
         if(c==14) to=op_14;
         if(c==15) to=op_15;
         if(c==16) to=op_16;
         if(c==17) to=op_17;
         if(c==18) to=op_18;
         if(c==19) to=op_19;
         if(c==20) to=op_20;
         if(c==21) to=op_21;
         if(c==22) to=op_22;
         if(c==23) to=op_23;
         if(c==24) to=op_24;
         if(c==25) to=op_25;
         if(c==26) to=op_26;
         if(c==27) to=op_27;
         if(c==28) to=op_28;
         if(c==29) to=op_29;
         if(c==30) to=op_30;
         if(c==31) to=op_31;
         if(c==32) to=op_32;
         if(c==33) to=op_33;
         if(c==34) to=op_34;
         if(c==35) to=op_35;
         if(c==36) to=op_36;
         if(c==37) to=op_37;
         if(c==38) to=op_38;
         if(c==39) to=op_39;
         if(c==40) to=op_40;
         if(c==41) to=op_41;
         if(c==42) to=op_42;
         if(c==43) to=op_43;
         if(c==44) to=op_44;
         if(c==45) to=op_45;
         if(c==46) to=op_46;
         if(c==47) to=op_47;
         if(c==48) to=op_48;
         if(c==49) to=op_49;
         if(c==50) to=op_50;
         if(c==51) to=op_51;
         if(c==52) to=op_52;
         if(c==53) to=op_53;
         if(c==54) to=op_54;
         if(c==55) to=op_55;
         if(c==56) to=op_56;
         if(c==57) to=op_57;
         if(c==58) to=op_58;
         if(c==59) to=op_59;
         if(c==60) to=op_60;
         if(c==61) to=op_61;
         if(c==62) to=op_62;
         if(c==63) to=op_63;
         if(c==64) to=op_64;
         if(c==65) to=op_65;
         if(c==66) to=op_66;
         if(c==67) to=op_67;
         if(c==68) to=op_68;
         if(c==69) to=op_69;
         if(c==70) to=op_70;
         if(c==71) to=op_71;
         if(c==72) to=op_72;
         if(c==73) to=op_73;
         if(c==74) to=op_74;
         if(c==75) to=op_75;
         if(c==76) to=op_76;
         if(c==77) to=op_77;
         if(c==78) to=op_78;
         if(c==79) to=op_79;
         if(c==80) to=op_80;
         if(c==81) to=op_81;
         if(c==82) to=op_82;
         if(c==83) to=op_83;
         if(c==84) to=op_84;
         if(c==85) to=op_85;
         if(c==86) to=op_86;
         if(c==87) to=op_87;
         if(c==88) to=op_88;
         if(c==89) to=op_89;
         if(c==90) to=op_90;
         if(c==91) to=op_91;
         if(c==92) to=op_92;
         if(c==93) to=op_93;
         if(c==94) to=op_94;
         if(c==95) to=op_95;
         if(c==96) to=op_96;
         if(c==97) to=op_97;
         if(c==98) to=op_98;
         if(c==99) to=op_99;
         if(c==100) to=op_100;
         if(c==101) to=op_101;
         }}}
   return(to);
   }
   
double BEPBuy() {
double d=0;
double bep=0;
   double to=0;double lt=0;int j=0;
   
   for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol())continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==0){
         to+= OrderOpenPrice()*OrderLots();
         lt+= OrderLots();
         j++;
     bep=(to/lt);    
    } }}
   d=NormalizeDouble(bep,Digits);
   return(d);
   }    
   
double TP_Dollar_Buy( ) {
double d=0;
double tp=0;
   double to=0;double lt=0;double bbep=0;double val_point_lt_TP_Buy=0;double dollarTP_Buy=0;double point_needed_TP_Buy=0;double get_TP_Buy=0;
   for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol())continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==0){
         
         to+= OrderOpenPrice()*OrderLots();
         lt+= OrderLots();
         
     val_point_lt_TP_Buy=lt*(MarketInfo(Symbol(),MODE_MINLOT));
     dollarTP_Buy=DollarTarget;
     point_needed_TP_Buy=dollarTP_Buy/val_point_lt_TP_Buy;
     get_TP_Buy=(point_needed_TP_Buy*Point)*MultipleRange;
     tp=to/lt+((get_TP_Buy*MultipleRange)*Point);
     }}}
   d=tp  ;
   return(d);
   }    

double Point_TP_Dollar_Buy( ) {
double d=0;
double tp=0;
   double to=0;double lt=0;double bbep=0;double val_point_lt_TP_Buy=0;double dollarTP_Buy=0;double point_needed_TP_Buy=0;double get_TP_Buy=0;
   for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==0){
         
         to+= OrderOpenPrice()*OrderLots();
         lt+= OrderLots();
         
     val_point_lt_TP_Buy=lt*(MarketInfo(Symbol(),MODE_MINLOT));
     dollarTP_Buy=DollarTarget;
     point_needed_TP_Buy=dollarTP_Buy/val_point_lt_TP_Buy;
     get_TP_Buy=(point_needed_TP_Buy*Point)*MultipleRange;
     tp=to/lt+((get_TP_Buy*MultipleRange)*Point);
     }}}
   d=get_TP_Buy  ;
   return(d);
   }

void Set_TP_Dollar_Buy ()
{ int j=0;
double be=0,tpb=0;
be=NormalizeDouble(BEPBuy(),Digits);
tpb= NormalizeDouble(TP_Dollar_Buy(),Digits);
   for(int i=OrdersTotal(); i>=0; i--) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
        bool g2= OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==0 ){
         if((OrderTakeProfit()>= 0 && DollarTarget>0 )
         ){     
j++;
bool cz= OrderModify(ordertiket_buy(j),orderopenprice_buy(j),OrderStopLoss(),tpb,OrderExpiration(),clrBrown);
}}}}}

}
//----------------------//
double TP_Partial_Percent_Buy( ) {
double d=0;
double tp=0;
   double to=0;double lt=0;double bbep=0;double val_point_lt_TP_Buy=0;double dollarTP_Buy=0;double point_needed_TP_Buy=0;double get_TP_Buy=0;
   for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol())continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==0){
         
         to+= OrderOpenPrice()*OrderLots();
         lt+= OrderLots();
         
     val_point_lt_TP_Buy=lt*(MarketInfo(Symbol(),MODE_MINLOT));
     dollarTP_Buy=T_Harian;
     point_needed_TP_Buy=dollarTP_Buy/val_point_lt_TP_Buy;
     get_TP_Buy=(point_needed_TP_Buy*Point)*MultipleRange;
     tp=(to/lt)+((get_TP_Buy*MultipleRange)*Point);
     }}}
   d=tp  ;
   if(d>2100)d=2100;
   return(d);
   }

double Point_TP_Partial_Percent_Buy( ) {
double d=0;
double tp=0;
   double to=0;double lt=0;double bbep=0;double val_point_lt_TP_Buy=0;double dollarTP_Buy=0;double point_needed_TP_Buy=0;double get_TP_Buy=0;
   for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==0){
         
         to+= OrderOpenPrice()*OrderLots();
         lt+= OrderLots();
         
     val_point_lt_TP_Buy=lt*(MarketInfo(Symbol(),MODE_MINLOT));
     dollarTP_Buy=T_Harian;
     point_needed_TP_Buy=dollarTP_Buy/val_point_lt_TP_Buy;
     get_TP_Buy=(point_needed_TP_Buy*Point)*MultipleRange;
     tp=to/lt+((get_TP_Buy*MultipleRange)*Point);
     }}}
   d=get_TP_Buy  ;  
   return(d);
   }    


void Set_TP_Partial_Percent_Buy ()
{ int j=0;
double be=0,tpb=0;
be=NormalizeDouble(BEPBuy(),Digits);
tpb= NormalizeDouble(TP_Partial_Percent_Buy(),Digits);
if(tpb>=2100)tpb=2100;
   for(int i=OrdersTotal()-1; i>=0; i--) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
        bool g2= OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==0 ){
         if((OrderTakeProfit()>= 0 )
        ){
         
j++; 
bool cz= OrderModify(ordertiket_buy(j),orderopenprice_buy(j),OrderStopLoss(),tpb,OrderExpiration(),clrBrown);
}}}}}
return;
}
//----------------------------//

double SL_Buy() {
double d=0;
double sl=0;double to=0;double lt=0;
 double val_point_lt_SL_Buy=0; double dollar_SL_Buy=0;double point_needed_SL_Buy=0;double get_SL_Buy=0;
   for(int i=OrdersTotal(); i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==0){
         
         to+= OrderOpenPrice()*OrderLots();
         lt+= OrderLots();
         
     val_point_lt_SL_Buy=lt*(MarketInfo(Symbol(),MODE_MINLOT));
     dollar_SL_Buy=AccountBalance()*(Risk/100);
     point_needed_SL_Buy=dollar_SL_Buy/val_point_lt_SL_Buy;
     get_SL_Buy=(point_needed_SL_Buy*Point)*MultipleRange;
     sl=to/lt-((get_SL_Buy*MultipleRange)*Point);
     }}}
   d=sl;
    
   return(d);
   }    

double Point_SL_Buy() {
double d=0;
double sl=0;double to=0;double lt=0;
 double val_point_lt_SL_Buy=0; double dollar_SL_Buy=0;double point_needed_SL_Buy=0;double get_SL_Buy=0;
   for(int i=OrdersTotal(); i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==0){
         
         to+= OrderOpenPrice()*OrderLots();
         lt+= OrderLots();
         
     val_point_lt_SL_Buy=lt*(MarketInfo(Symbol(),MODE_MINLOT));
   dollar_SL_Buy=AccountBalance()*(Risk/100);
     point_needed_SL_Buy=dollar_SL_Buy/val_point_lt_SL_Buy;
     get_SL_Buy=(point_needed_SL_Buy*Point)*MultipleRange;
     sl=to/lt-((get_SL_Buy*MultipleRange)*Point);
     }}}
   d=get_SL_Buy;
    
   return(d);
   } 

//---Set TPSL



void Set_SL_Buy ()
{ int j=0,k=0;
double be=0,slb=0;
 be= BEPBuy();
 slb= SL_Buy();
if(slb<=0)slb=10;
   for(int i=OrdersTotal(); i>=0; i--) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
        bool g2= OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==0 && OrderStopLoss()!=SL_Buy()){
         if((OrderStopLoss()>= 0 ) 
          ){
j++;
bool cz= OrderModify(ordertiket_buy(j),orderopenprice_buy(j),slb,OrderTakeProfit(),OrderExpiration(),clrBlue);
}
}}}}
return;
}

void Set_SL_Clear_Buy ()
{ int j=0,k=0;
double be=0,slb=0;
 be= BEPBuy();
 slb=0;
   for(int i=OrdersTotal(); i>=0; i--) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
        bool g2= OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==0){
         if(OrderStopLoss()> 0 ){
j++;
bool cz= OrderModify(ordertiket_buy(j),orderopenprice_buy(j),0,OrderTakeProfit(),OrderExpiration(),clrBlack);
}
}}}}
return;
}

//----------Conversion TPSL-SELL-----------//

int ordertiket_sell( int c) {
   int i=0,
   tc_0 =0, 
   tc_1 =0,
   tc_2=0,
   tc_3=0,
   tc_4=0,
   tc_5=0,
   tc_6=0,
   tc_7 =0,
   tc_8 =0,
   tc_9 =0,
   tc_10 =0,
   tc_11 =0,
   tc_12 =0,
   tc_13 =0,
   tc_14 =0,
   tc_15 =0,
   tc_16 =0,
   tc_17 =0,
   tc_18 =0,
   tc_19 =0,
   tc_20 =0,
   tc_21 =0,
   tc_22 =0,
   tc_23 =0,
   tc_24 =0,
   tc_25 =0,
   tc_26 =0,
   tc_27 =0,
   tc_28 =0,
   tc_29 =0,
   tc_30 =0,
   tc_31 =0,
   tc_32 =0,
   tc_33 =0,
   tc_34 =0,
   tc_35 =0,
   tc_36 =0,
   tc_37 =0,
   tc_38 =0,
   tc_39 =0,
   tc_40 =0,
   tc_41 =0,
   tc_42 =0,
   tc_43 =0,
   tc_44 =0,
   tc_45 =0,
   tc_46 =0,
   tc_47 =0,
   tc_48 =0,
   tc_49 =0,
   tc_50 =0,
   tc_51 =0,
   tc_52 =0,
   tc_53 =0,
   tc_54 =0,
   tc_55 =0,
   tc_56 =0,
   tc_57 =0,
   tc_58 =0,
   tc_59 =0,
   tc_60 =0,
   tc_61 =0,
   tc_62 =0,
   tc_63 =0,
   tc_64 =0,
   tc_65 =0,
   tc_66 =0,
   tc_67 =0,
   tc_68 =0,
   tc_69 =0,
   tc_70 =0,
   tc_71 =0,
   tc_72 =0,
   tc_73 =0,
   tc_74 =0,
   tc_75 =0,
   tc_76 =0,
   tc_77 =0,
   tc_78 =0,
   tc_79 =0,
   tc_80 =0,
   tc_81 =0,
   tc_82 =0,
   tc_83 =0,
   tc_84 =0,
   tc_85 =0,
   tc_86 =0,
   tc_87 =0,
   tc_88 =0,
   tc_89 =0,
   tc_90 =0,
   tc_91 =0,
   tc_92 =0,
   tc_93 =0,
   tc_94 =0,
   tc_95 =0,
   tc_96 =0,
   tc_97 =0,
   tc_98 =0,
   tc_99 =0,
   tc_100 =0,
   tc_101 =0,
   to =0;
   
    
     for(int j=0; j<OrdersTotal(); j++) {
         if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic && OrderType()==1){
         i++;
         if(i==0  ) tc_0= OrderTicket();
         if(i==1  ) tc_1= OrderTicket();
         if(i==2  ) tc_2= OrderTicket();
         if(i==3  ) tc_3= OrderTicket();
         if(i==4  ) tc_4= OrderTicket();
         if(i==5  ) tc_5= OrderTicket();
         if(i==6  ) tc_6= OrderTicket();
         if(i==7  ) tc_7= OrderTicket();
         if(i==8  ) tc_8= OrderTicket();
         if(i==9  ) tc_9= OrderTicket();
         if(i==10 ) tc_10= OrderTicket();
         if(i==11  ) tc_11= OrderTicket();
         if(i==12  ) tc_12= OrderTicket();
         if(i==13  ) tc_13= OrderTicket();
         if(i==14  ) tc_14= OrderTicket();
         if(i==15  ) tc_15= OrderTicket();
         if(i==16  ) tc_16= OrderTicket();
         if(i==17  ) tc_17= OrderTicket();
         if(i==18  ) tc_18= OrderTicket();
         if(i==19  ) tc_19= OrderTicket();
         if(i==20  ) tc_20= OrderTicket();
         if(i==21  ) tc_21= OrderTicket();
         if(i==22  ) tc_22= OrderTicket();
         if(i==23  ) tc_23= OrderTicket();
         if(i==24  ) tc_24= OrderTicket();
         if(i==25  ) tc_25= OrderTicket();
         if(i==26  ) tc_26= OrderTicket();
         if(i==27  ) tc_27= OrderTicket();
         if(i==28  ) tc_28= OrderTicket();
         if(i==29  ) tc_29= OrderTicket();
         if(i==30  ) tc_30= OrderTicket();
         if(i==31  ) tc_31= OrderTicket();
         if(i==32  ) tc_32= OrderTicket();
         if(i==33  ) tc_33= OrderTicket();
         if(i==34  ) tc_34= OrderTicket();
         if(i==35  ) tc_35= OrderTicket();
         if(i==36  ) tc_36= OrderTicket();
         if(i==37  ) tc_37= OrderTicket();
         if(i==38  ) tc_38= OrderTicket();
         if(i==39  ) tc_39= OrderTicket();
         if(i==40  ) tc_40= OrderTicket();
         if(i==41  ) tc_41= OrderTicket();
         if(i==42  ) tc_42= OrderTicket();
         if(i==43  ) tc_43= OrderTicket();
         if(i==44  ) tc_44= OrderTicket();
         if(i==45  ) tc_45= OrderTicket();
         if(i==46  ) tc_46= OrderTicket();
         if(i==47  ) tc_47= OrderTicket();
         if(i==48  ) tc_48= OrderTicket();
         if(i==49  ) tc_49= OrderTicket();
         if(i==50  ) tc_50= OrderTicket();
         if(i==51  ) tc_51= OrderTicket();
         if(i==52  ) tc_52= OrderTicket();
         if(i==53  ) tc_53= OrderTicket();
         if(i==54  ) tc_54= OrderTicket();
         if(i==55  ) tc_55= OrderTicket();
         if(i==56  ) tc_56= OrderTicket();
         if(i==57  ) tc_57= OrderTicket();
         if(i==58  ) tc_58= OrderTicket();
         if(i==59  ) tc_59= OrderTicket();
         if(i==60  ) tc_60= OrderTicket();
         if(i==61  ) tc_61= OrderTicket();
         if(i==62  ) tc_62= OrderTicket();
         if(i==63  ) tc_63= OrderTicket();
         if(i==64  ) tc_64= OrderTicket();
         if(i==65  ) tc_65= OrderTicket();
         if(i==66  ) tc_66= OrderTicket();
         if(i==67  ) tc_67= OrderTicket();
         if(i==68  ) tc_68= OrderTicket();
         if(i==69  ) tc_69= OrderTicket();
         if(i==70  ) tc_70= OrderTicket();
         if(i==71  ) tc_71= OrderTicket();
         if(i==72  ) tc_72= OrderTicket();
         if(i==73  ) tc_73= OrderTicket();
         if(i==74 ) tc_74= OrderTicket();
         if(i==75 ) tc_75= OrderTicket();
         if(i==76  ) tc_76= OrderTicket();
         if(i==77  ) tc_77= OrderTicket();
         if(i==78 ) tc_78= OrderTicket();
         if(i==79  ) tc_79= OrderTicket();
         if(i==80  ) tc_80= OrderTicket();
         if(i==81 ) tc_81= OrderTicket();
         if(i==82  ) tc_82= OrderTicket();
         if(i==83  ) tc_83= OrderTicket();
         if(i==84  ) tc_84= OrderTicket();
         if(i==85  ) tc_85= OrderTicket();
         if(i==86  ) tc_86= OrderTicket();
         if(i==87  ) tc_87= OrderTicket();
         if(i==88 ) tc_88= OrderTicket();
         if(i==89 ) tc_89= OrderTicket();
         if(i==90  ) tc_90= OrderTicket();
         if(i==91  ) tc_91= OrderTicket();
         if(i==92  ) tc_92= OrderTicket();
         if(i==93  ) tc_93= OrderTicket();
         if(i==94  ) tc_94= OrderTicket();
         if(i==95  ) tc_95= OrderTicket();
         if(i==96 ) tc_96= OrderTicket();
         if(i==97  ) tc_97= OrderTicket();
         if(i==98  ) tc_98= OrderTicket();
         if(i==99  ) tc_99= OrderTicket();
         if(i==100  ) tc_100= OrderTicket();
         if(i==101  ) tc_101= OrderTicket(); 

         
      
      
         if(c==0) to=tc_0;     
         if(c==1) to=tc_1;
         if(c==2) to=tc_2;
         if(c==3) to=tc_3;
         if(c==4) to=tc_4;
         if(c==5) to=tc_5;
         if(c==6) to=tc_6;
         if(c==7) to=tc_7;
         if(c==8) to=tc_8;
         if(c==9) to=tc_9;
         if(c==10) to=tc_10;
         if(c==11) to=tc_11;
         if(c==12) to=tc_12;
         if(c==13) to=tc_13;
         if(c==14) to=tc_14;
         if(c==15) to=tc_15;
         if(c==16) to=tc_16;
         if(c==17) to=tc_17;
         if(c==18) to=tc_18;
         if(c==19) to=tc_19;
         if(c==20) to=tc_20;
         if(c==21) to=tc_21;
         if(c==22) to=tc_22;
         if(c==23) to=tc_23;
         if(c==24) to=tc_24;
         if(c==25) to=tc_25;
         if(c==26) to=tc_26;
         if(c==27) to=tc_27;
         if(c==28) to=tc_28;
         if(c==29) to=tc_29;
         if(c==30) to=tc_30;
         if(c==31) to=tc_31;
         if(c==32) to=tc_32;
         if(c==33) to=tc_33;
         if(c==34) to=tc_34;
         if(c==35) to=tc_35;
         if(c==36) to=tc_36;
         if(c==37) to=tc_37;
         if(c==38) to=tc_38;
         if(c==39) to=tc_39;
         if(c==40) to=tc_40;
         if(c==41) to=tc_41;
         if(c==42) to=tc_42;
         if(c==43) to=tc_43;
         if(c==44) to=tc_44;
         if(c==45) to=tc_45;
         if(c==46) to=tc_46;
         if(c==47) to=tc_47;
         if(c==48) to=tc_48;
         if(c==49) to=tc_49;
         if(c==50) to=tc_50;
         if(c==51) to=tc_51;
         if(c==52) to=tc_52;
         if(c==53) to=tc_53;
         if(c==54) to=tc_54;
         if(c==55) to=tc_55;
         if(c==56) to=tc_56;
         if(c==57) to=tc_57;
         if(c==58) to=tc_58;
         if(c==59) to=tc_59;
         if(c==60) to=tc_60;
         if(c==61) to=tc_61;
         if(c==62) to=tc_62;
         if(c==63) to=tc_63;
         if(c==64) to=tc_64;
         if(c==65) to=tc_65;
         if(c==66) to=tc_66;
         if(c==67) to=tc_67;
         if(c==68) to=tc_68;
         if(c==69) to=tc_69;
         if(c==70) to=tc_70;
         if(c==71) to=tc_71;
         if(c==72) to=tc_72;
         if(c==73) to=tc_73;
         if(c==74) to=tc_74;
         if(c==75) to=tc_75;
         if(c==76) to=tc_76;
         if(c==77) to=tc_77;
         if(c==78) to=tc_78;
         if(c==79) to=tc_79;
         if(c==80) to=tc_80;
         if(c==81) to=tc_81;
         if(c==82) to=tc_82;
         if(c==83) to=tc_83;
         if(c==84) to=tc_84;
         if(c==85) to=tc_85;
         if(c==86) to=tc_86;
         if(c==87) to=tc_87;
         if(c==88) to=tc_88;
         if(c==89) to=tc_89;
         if(c==90) to=tc_90;
         if(c==91) to=tc_91;
         if(c==92) to=tc_92;
         if(c==93) to=tc_93;
         if(c==94) to=tc_94;
         if(c==95) to=tc_95;
         if(c==96) to=tc_96;
         if(c==97) to=tc_97;
         if(c==98) to=tc_98;
         if(c==99) to=tc_99;
         if(c==100) to=tc_100;
         if(c==101) to=tc_101;
         }}}
   return(to);
   }

double orderopenprice_sell( int c) {
   int i=0;
double
   op_0 =0, 
   op_1 =0,
   op_2=0,
   op_3=0,
   op_4=0,
   op_5=0,
   op_6=0,
   op_7 =0,
   op_8 =0,
   op_9 =0,
   op_10 =0,
   op_11 =0,
   op_12 =0,
   op_13 =0,
   op_14 =0,
   op_15 =0,
   op_16 =0,
   op_17 =0,
   op_18 =0,
   op_19 =0,
   op_20 =0,
   op_21 =0,
   op_22 =0,
   op_23 =0,
   op_24 =0,
   op_25 =0,
   op_26 =0,
   op_27 =0,
   op_28 =0,
   op_29 =0,
   op_30 =0,
   op_31 =0,
   op_32 =0,
   op_33 =0,
   op_34 =0,
   op_35 =0,
   op_36 =0,
   op_37 =0,
   op_38 =0,
   op_39 =0,
   op_40 =0,
   op_41 =0,
   op_42 =0,
   op_43 =0,
   op_44 =0,
   op_45 =0,
   op_46 =0,
   op_47 =0,
   op_48 =0,
   op_49 =0,
   op_50 =0,
   op_51 =0,
   op_52 =0,
   op_53 =0,
   op_54 =0,
   op_55 =0,
   op_56 =0,
   op_57 =0,
   op_58 =0,
   op_59 =0,
   op_60 =0,
   op_61 =0,
   op_62 =0,
   op_63 =0,
   op_64 =0,
   op_65 =0,
   op_66 =0,
   op_67 =0,
   op_68 =0,
   op_69 =0,
   op_70 =0,
   op_71 =0,
   op_72 =0,
   op_73 =0,
   op_74 =0,
   op_75 =0,
   op_76 =0,
   op_77 =0,
   op_78 =0,
   op_79 =0,
   op_80 =0,
   op_81 =0,
   op_82 =0,
   op_83 =0,
   op_84 =0,
   op_85 =0,
   op_86 =0,
   op_87 =0,
   op_88 =0,
   op_89 =0,
   op_90 =0,
   op_91 =0,
   op_92 =0,
   op_93 =0,
   op_94 =0,
   op_95 =0,
   op_96 =0,
   op_97 =0,
   op_98 =0,
   op_99 =0,
   op_100 =0,
   op_101 =0,
   to =0;
   
    
     for(int j=0; j<OrdersTotal(); j++) {
         if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic && OrderType()==1){
         i++;
         if(i==0  ) op_0= OrderOpenPrice();
         if(i==1  ) op_1= OrderOpenPrice();
         if(i==2  ) op_2= OrderOpenPrice();
         if(i==3  ) op_3= OrderOpenPrice();
         if(i==4  ) op_4= OrderOpenPrice();
         if(i==5  ) op_5= OrderOpenPrice();
         if(i==6  ) op_6= OrderOpenPrice();
         if(i==7  ) op_7= OrderOpenPrice();
         if(i==8  ) op_8= OrderOpenPrice();
         if(i==9  ) op_9= OrderOpenPrice();
         if(i==10 ) op_10= OrderOpenPrice();
         if(i==11  ) op_11= OrderOpenPrice();
         if(i==12  ) op_12= OrderOpenPrice();
         if(i==13  ) op_13= OrderOpenPrice();
         if(i==14  ) op_14= OrderOpenPrice();
         if(i==15  ) op_15= OrderOpenPrice();
         if(i==16  ) op_16= OrderOpenPrice();
         if(i==17  ) op_17= OrderOpenPrice();
         if(i==18  ) op_18= OrderOpenPrice();
         if(i==19  ) op_19= OrderOpenPrice();
         if(i==20  ) op_20= OrderOpenPrice();
         if(i==21  ) op_21= OrderOpenPrice();
         if(i==22  ) op_22= OrderOpenPrice();
         if(i==23  ) op_23= OrderOpenPrice();
         if(i==24  ) op_24= OrderOpenPrice();
         if(i==25  ) op_25= OrderOpenPrice();
         if(i==26  ) op_26= OrderOpenPrice();
         if(i==27  ) op_27= OrderOpenPrice();
         if(i==28  ) op_28= OrderOpenPrice();
         if(i==29  ) op_29= OrderOpenPrice();
         if(i==30  ) op_30= OrderOpenPrice();
         if(i==31  ) op_31= OrderOpenPrice();
         if(i==32  ) op_32= OrderOpenPrice();
         if(i==33  ) op_33= OrderOpenPrice();
         if(i==34  ) op_34= OrderOpenPrice();
         if(i==35  ) op_35= OrderOpenPrice();
         if(i==36  ) op_36= OrderOpenPrice();
         if(i==37  ) op_37= OrderOpenPrice();
         if(i==38  ) op_38= OrderOpenPrice();
         if(i==39  ) op_39= OrderOpenPrice();
         if(i==40  ) op_40= OrderOpenPrice();
         if(i==41  ) op_41= OrderOpenPrice();
         if(i==42  ) op_42= OrderOpenPrice();
         if(i==43  ) op_43= OrderOpenPrice();
         if(i==44  ) op_44= OrderOpenPrice();
         if(i==45  ) op_45= OrderOpenPrice();
         if(i==46  ) op_46= OrderOpenPrice();
         if(i==47  ) op_47= OrderOpenPrice();
         if(i==48  ) op_48= OrderOpenPrice();
         if(i==49  ) op_49= OrderOpenPrice();
         if(i==50  ) op_50= OrderOpenPrice();
         if(i==51  ) op_51= OrderOpenPrice();
         if(i==52  ) op_52= OrderOpenPrice();
         if(i==53  ) op_53= OrderOpenPrice();
         if(i==54  ) op_54= OrderOpenPrice();
         if(i==55  ) op_55= OrderOpenPrice();
         if(i==56  ) op_56= OrderOpenPrice();
         if(i==57  ) op_57= OrderOpenPrice();
         if(i==58  ) op_58= OrderOpenPrice();
         if(i==59  ) op_59= OrderOpenPrice();
         if(i==60  ) op_60= OrderOpenPrice();
         if(i==61  ) op_61= OrderOpenPrice();
         if(i==62  ) op_62= OrderOpenPrice();
         if(i==63  ) op_63= OrderOpenPrice();
         if(i==64  ) op_64= OrderOpenPrice();
         if(i==65  ) op_65= OrderOpenPrice();
         if(i==66  ) op_66= OrderOpenPrice();
         if(i==67  ) op_67= OrderOpenPrice();
         if(i==68  ) op_68= OrderOpenPrice();
         if(i==69  ) op_69= OrderOpenPrice();
         if(i==70  ) op_70= OrderOpenPrice();
         if(i==71  ) op_71= OrderOpenPrice();
         if(i==72  ) op_72= OrderOpenPrice();
         if(i==73  ) op_73= OrderOpenPrice();
         if(i==74 ) op_74= OrderOpenPrice();
         if(i==75 ) op_75= OrderOpenPrice();
         if(i==76  ) op_76= OrderOpenPrice();
         if(i==77  ) op_77= OrderOpenPrice();
         if(i==78 ) op_78= OrderOpenPrice();
         if(i==79  ) op_79= OrderOpenPrice();
         if(i==80  ) op_80= OrderOpenPrice();
         if(i==81 ) op_81= OrderOpenPrice();
         if(i==82  ) op_82= OrderOpenPrice();
         if(i==83  ) op_83= OrderOpenPrice();
         if(i==84  ) op_84= OrderOpenPrice();
         if(i==85  ) op_85= OrderOpenPrice();
         if(i==86  ) op_86= OrderOpenPrice();
         if(i==87  ) op_87= OrderOpenPrice();
         if(i==88 ) op_88= OrderOpenPrice();
         if(i==89 ) op_89= OrderOpenPrice();
         if(i==90  ) op_90= OrderOpenPrice();
         if(i==91  ) op_91= OrderOpenPrice();
         if(i==92  ) op_92= OrderOpenPrice();
         if(i==93  ) op_93= OrderOpenPrice();
         if(i==94  ) op_94= OrderOpenPrice();
         if(i==95  ) op_95= OrderOpenPrice();
         if(i==96 ) op_96= OrderOpenPrice();
         if(i==97  ) op_97= OrderOpenPrice();
         if(i==98  ) op_98= OrderOpenPrice();
         if(i==99  ) op_99= OrderOpenPrice();
         if(i==100  ) op_100= OrderOpenPrice();
         if(i==101  ) op_101= OrderOpenPrice();


         if(c==0) to=op_0;     
         if(c==1) to=op_1;
         if(c==2) to=op_2;
         if(c==3) to=op_3;
         if(c==4) to=op_4;
         if(c==5) to=op_5;
         if(c==6) to=op_6;
         if(c==7) to=op_7;
         if(c==8) to=op_8;
         if(c==9) to=op_9;
         if(c==10) to=op_10;
         if(c==11) to=op_11;
         if(c==12) to=op_12;
         if(c==13) to=op_13;
         if(c==14) to=op_14;
         if(c==15) to=op_15;
         if(c==16) to=op_16;
         if(c==17) to=op_17;
         if(c==18) to=op_18;
         if(c==19) to=op_19;
         if(c==20) to=op_20;
         if(c==21) to=op_21;
         if(c==22) to=op_22;
         if(c==23) to=op_23;
         if(c==24) to=op_24;
         if(c==25) to=op_25;
         if(c==26) to=op_26;
         if(c==27) to=op_27;
         if(c==28) to=op_28;
         if(c==29) to=op_29;
         if(c==30) to=op_30;
         if(c==31) to=op_31;
         if(c==32) to=op_32;
         if(c==33) to=op_33;
         if(c==34) to=op_34;
         if(c==35) to=op_35;
         if(c==36) to=op_36;
         if(c==37) to=op_37;
         if(c==38) to=op_38;
         if(c==39) to=op_39;
         if(c==40) to=op_40;
         if(c==41) to=op_41;
         if(c==42) to=op_42;
         if(c==43) to=op_43;
         if(c==44) to=op_44;
         if(c==45) to=op_45;
         if(c==46) to=op_46;
         if(c==47) to=op_47;
         if(c==48) to=op_48;
         if(c==49) to=op_49;
         if(c==50) to=op_50;
         if(c==51) to=op_51;
         if(c==52) to=op_52;
         if(c==53) to=op_53;
         if(c==54) to=op_54;
         if(c==55) to=op_55;
         if(c==56) to=op_56;
         if(c==57) to=op_57;
         if(c==58) to=op_58;
         if(c==59) to=op_59;
         if(c==60) to=op_60;
         if(c==61) to=op_61;
         if(c==62) to=op_62;
         if(c==63) to=op_63;
         if(c==64) to=op_64;
         if(c==65) to=op_65;
         if(c==66) to=op_66;
         if(c==67) to=op_67;
         if(c==68) to=op_68;
         if(c==69) to=op_69;
         if(c==70) to=op_70;
         if(c==71) to=op_71;
         if(c==72) to=op_72;
         if(c==73) to=op_73;
         if(c==74) to=op_74;
         if(c==75) to=op_75;
         if(c==76) to=op_76;
         if(c==77) to=op_77;
         if(c==78) to=op_78;
         if(c==79) to=op_79;
         if(c==80) to=op_80;
         if(c==81) to=op_81;
         if(c==82) to=op_82;
         if(c==83) to=op_83;
         if(c==84) to=op_84;
         if(c==85) to=op_85;
         if(c==86) to=op_86;
         if(c==87) to=op_87;
         if(c==88) to=op_88;
         if(c==89) to=op_89;
         if(c==90) to=op_90;
         if(c==91) to=op_91;
         if(c==92) to=op_92;
         if(c==93) to=op_93;
         if(c==94) to=op_94;
         if(c==95) to=op_95;
         if(c==96) to=op_96;
         if(c==97) to=op_97;
         if(c==98) to=op_98;
         if(c==99) to=op_99;
         if(c==100) to=op_100;
         if(c==101) to=op_101;
         }}}
   return(to);
   }
   
double BEPSell( ) {
double d=0;
double bep=0;

   double sto=0;double lts=0;
  for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==1){
         
         sto+= OrderOpenPrice()*OrderLots();
         lts+= OrderLots();
    
     bep=(sto/lts);
     }}}  
   d=bep;
   return(d);
   }    
double TP_Dollar_Sell(  ) {
double d=0;
double tp=0;
   double sto=0;double lts=0;
   double val_point_lt_TP_Sell=0;double dollarTP_Sell=0;double point_needed_TP_Sell=0;double get_TP_Sell=0;

  for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==1){
         
         sto+= OrderOpenPrice()*OrderLots();
         lts+= OrderLots();
        
      val_point_lt_TP_Sell=lts*(MarketInfo(Symbol(),MODE_MINLOT));
      dollarTP_Sell=DollarTarget;
      point_needed_TP_Sell=dollarTP_Sell/val_point_lt_TP_Sell;
      get_TP_Sell=(point_needed_TP_Sell*Point)*MultipleRange;
      tp=sto/lts-((get_TP_Sell*MultipleRange)*Point);
     }}}
   d=tp;
    
   return(d);
   }


double Point_TP_Dollar_Sell(  ) {
double d=0;
double tp=0;
   double sto=0;double lts=0;
   double val_point_lt_TP_Sell=0;double dollarTP_Sell=0;double point_needed_TP_Sell=0;double get_TP_Sell=0;

  for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==1){
         
         sto+= OrderOpenPrice()*OrderLots();
         lts+= OrderLots();
        
      val_point_lt_TP_Sell=lts*(MarketInfo(Symbol(),MODE_MINLOT));
      dollarTP_Sell=DollarTarget;
      point_needed_TP_Sell=dollarTP_Sell/val_point_lt_TP_Sell;
      get_TP_Sell=(point_needed_TP_Sell*Point)*MultipleRange;
      tp=sto/lts-((get_TP_Sell*MultipleRange)*Point);
     }}}
   d=get_TP_Sell;
    
   return(d);
   }
   
void Set_TP_Dollar_Sell ()
{ int j=0;
double be=0,tps=0;
be= NormalizeDouble(BEPSell(),Digits);
tps= NormalizeDouble(TP_Dollar_Sell(),Digits);

   for(int i=OrdersTotal(); i>=0; i--) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
        bool g2= OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==1){
         if((OrderTakeProfit()>=0 && DollarTarget>0  )
         ){
j++;
bool cz= OrderModify(ordertiket_sell(j),orderopenprice_sell(j),OrderStopLoss(),tps,OrderExpiration(),clrBisque);
}}}}}
return;
}

double TP_Percent_Sell(  ) {
double d=0;
double tp=0;
   double sto=0;double lts=0;
   double val_point_lt_TP_Sell=0;double dollarTP_Sell=0;double point_needed_TP_Sell=0;double get_TP_Sell=0;

   for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol())continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==1){
         
         sto+= OrderOpenPrice()*OrderLots();
         lts+= OrderLots();
        
      val_point_lt_TP_Sell=lts*(MarketInfo(Symbol(),MODE_MINLOT));
      dollarTP_Sell=T_Harian;
      point_needed_TP_Sell=dollarTP_Sell/val_point_lt_TP_Sell;
      get_TP_Sell=(point_needed_TP_Sell*Point)*MultipleRange;
      tp=sto/lts-((get_TP_Sell*MultipleRange)*Point);
     }}}
   d=tp;
   return(d);
   }
   
double Point_TP_Percent_Sell(  ) {
double d=0;
double tp=0;
   double sto=0;double lts=0;
   double val_point_lt_TP_Sell=0;double dollarTP_Sell=0;double point_needed_TP_Sell=0;double get_TP_Sell=0;

  for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==1){
         
         sto+= OrderOpenPrice()*OrderLots();
         lts+= OrderLots();
        
      val_point_lt_TP_Sell=lts*(MarketInfo(Symbol(),MODE_MINLOT));
      dollarTP_Sell=T_Harian;
      point_needed_TP_Sell=dollarTP_Sell/val_point_lt_TP_Sell;
      get_TP_Sell=(point_needed_TP_Sell*Point)*MultipleRange;
      tp=sto/lts-((get_TP_Sell*MultipleRange)*Point);
     }}}
   d=get_TP_Sell;
    
   return(d);
   }

void Set_TP_Partial_Percent_Sell ()
{ int j=0;
double be=0,tps=0;
be= NormalizeDouble(BEPSell(),Digits);
tps= NormalizeDouble( TP_Percent_Sell(),Digits);
if(tps<0)tps=0;

   for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol())continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==1){
         if((OrderTakeProfit()>= 0 )
          ){
j++;
bool cz= OrderModify(ordertiket_sell(j),orderopenprice_sell(j),OrderStopLoss(),tps,OrderExpiration(),clrBlueViolet);
}}}}
return;
}

double SL_Sell() {
double d=0;
double sl=0;double to=0;double lt=0;
 double val_point_lt_SL_Sell=0; double dollar_SL_Sell=0;
 double point_needed_SL_Sell=0;double get_SL_Sell=0;
   
   for(int i=OrdersTotal(); i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==1){
         
         to+= OrderOpenPrice()*OrderLots();
         lt+= OrderLots();
         
     val_point_lt_SL_Sell=lt*(MarketInfo(Symbol(),MODE_MINLOT));
     dollar_SL_Sell=AccountBalance()*(Risk/100);
     point_needed_SL_Sell=dollar_SL_Sell/val_point_lt_SL_Sell;
     get_SL_Sell=(point_needed_SL_Sell*Point)*MultipleRange;
     sl=(to/lt)+((get_SL_Sell*MultipleRange)*Point);
     }}}
   d=sl;
   
   return(d);
   }    

double Point_SL_Sell() {
double d=0;
double sl=0;double to=0;double lt=0;
 double val_point_lt_SL_Sell=0; double dollar_SL_Sell=0;
 double point_needed_SL_Sell=0;double get_SL_Sell=0;
 
    for(int i=OrdersTotal(); i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==1){
         
         to+= OrderOpenPrice()*OrderLots();
         lt+= OrderLots();
         
     val_point_lt_SL_Sell =lt*(MarketInfo(Symbol(),MODE_MINLOT));
     dollar_SL_Sell=AccountBalance()*(Risk/100);
     point_needed_SL_Sell=dollar_SL_Sell/val_point_lt_SL_Sell;
     get_SL_Sell=(point_needed_SL_Sell*Point)*MultipleRange;
     sl=(to/lt)+((get_SL_Sell*MultipleRange)*Point);
     }}}
   d=get_SL_Sell;
    
   return(d);
   } 

//---Set TPSL



void Set_SL_Sell ()
{ int j=0;
double be=0,sls=0;
 be= NormalizeDouble(BEPSell(),Digits);
 sls= NormalizeDouble(SL_Sell(),Digits);
if(sls>=3000)sls=3000;
    if(sls<3000)sls=SL_Sell();
    for(int i=OrdersTotal(); i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==1){
         if((OrderStopLoss()>= 0 )
          ){
j++;
bool cz= OrderModify(ordertiket_sell(j),orderopenprice_sell(j),sls,OrderTakeProfit(),OrderExpiration(),clrGray);
}
}}}
return;
}

void Set_SL_Clear_Sell ()
{ int j=0;
double be=0,sls=0;
 be= NormalizeDouble(BEPSell(),Digits);
 sls=0;
     for(int i=OrdersTotal()-1; i>=0; i--) {
         bool g2=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol())continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic ){
         if(OrderType()==1){
         if(OrderStopLoss()>0 ){
j++;
bool cz= OrderModify(ordertiket_sell(j),orderopenprice_sell(j),0,OrderTakeProfit(),OrderExpiration(),clrBlack);

}}}}
return;
}


void HargaMarti() { 
   SellTeratas = 0;
   BuyTerbawah = 100000;
   SellTerbawah = 100000;
   BuyTeratas = 0;

   for (int i=0; i < OrdersTotal(); i++) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic) {
            if(OrderType()==OP_BUY && OrderOpenPrice() < BuyTerbawah) BuyTerbawah = OrderOpenPrice();
            if(OrderType()==OP_SELL && OrderOpenPrice() > SellTeratas) SellTeratas = OrderOpenPrice();
         }            else
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic) {
            if(OrderType()==OP_BUY && OrderOpenPrice() > BuyTeratas) BuyTeratas = OrderOpenPrice();
            if(OrderType()==OP_SELL && OrderOpenPrice() < SellTerbawah) SellTerbawah = OrderOpenPrice();
         }            
     }

   }return;
}

double AccumulationLots(){
double d=0;
d=
Lots_00+
Lots_01+
Lots_02+
Lots_03+
Lots_04+
Lots_05+
Lots_06+
Lots_07+
Lots_08+
Lots_09+
Lots_10+
Lots_11+
Lots_12+
Lots_13+
Lots_14+
Lots_15+
Lots_16+
Lots_17+
Lots_18+
Lots_19+
Lots_20+
Lots_21+
Lots_22+
Lots_23+
Lots_24+
Lots_25+
Lots_26+
Lots_27+
Lots_28+
Lots_29+
Lots_30+
Lots_31+
Lots_32+
Lots_33+
Lots_34+
Lots_35+
Lots_36+
Lots_37+
Lots_38+
Lots_39+
Lots_40+
Lots_41+
Lots_42+
Lots_43+
Lots_44+
Lots_45+
Lots_46+
Lots_47+
Lots_48+
Lots_49+
Lots_50+
Lots_51+
Lots_52+
Lots_53+
Lots_54+
Lots_55+
Lots_56+
Lots_57+
Lots_58+
Lots_59+
Lots_60+
Lots_61+
Lots_62+
Lots_63+
Lots_64+
Lots_65+
Lots_66+
Lots_67+
Lots_68+
Lots_69+
Lots_70+
Lots_71+
Lots_72+
Lots_73+
Lots_74+
Lots_75+
Lots_76+
Lots_77+
Lots_78+
Lots_79+
Lots_80+
Lots_81+
Lots_82+
Lots_83+
Lots_84+
Lots_85+
Lots_86+
Lots_87+
Lots_88+
Lots_89+
Lots_90+
Lots_91+
Lots_92+
Lots_93+
Lots_94+
Lots_95+
Lots_96+
Lots_97+
Lots_98+
Lots_99+
Lots_100;

return(d) ;
}
//+------------------------------------------------------------------+


void DISPLAY(){

  text = "";   
   text = " \n\n\n                                          INDONESIA GRID COMPOUND MANAGER 2022"
        +" \n                                         ==============================="
        +" \n                                         tiket buy                : "+" $ "+IntegerToString(ordertiket_buy(1))+" "
        +" \n                                         tiket sell                : "+" $ "+IntegerToString(ordertiket_sell(1))+" "
       +" \n                                         ProfitAll                 : "+" $ "+DoubleToStr(NormalizeDouble(DailyReturns(),2),2)+" "
        +" \n                                         ProfitBuy                 : "+" $ "+DoubleToStr(NormalizeDouble(DailyReturn(0),2),2)+" "
        +" \n                                         ProfitSell                : "+" $ "+DoubleToStr(NormalizeDouble(DailyReturn(1),2),2)+" "
        +" \n                                         Target                : "+" $ "+DoubleToStr(NormalizeDouble(T_Harian,2),2)+" "
        +" \n                                         ==============================="
        +" \n                                         Equity                : "+" $ "+DoubleToStr(NormalizeDouble(AccountEquity(),2),2)+" "
        +" \n                                         Balance              : "+" $ "+DoubleToStr(NormalizeDouble(AccountBalance(),2),2)+" "
        +" \n                                         Balance To Trade : "+" $ "+DoubleToStr(NormalizeDouble(BalanceToTrade,2),2)+" "
        +" \n                                         Balance To Use      : "+"- $ "+DoubleToStr(NormalizeDouble(Sum_Balance,2),2)+" "
        +" \n                                         ==============================="
        +" \n                                         CountTrades              : "+" "+DoubleToStr(NormalizeDouble(NumLines,0),0)+" Grid"
        +" \n                                         PipStep Sell              : "+" "+DoubleToStr(NormalizeDouble(MartiLayer(1)*Point,3),3)+" Point"
        +" \n                                         PipStep Buy              : "+" "+DoubleToStr(NormalizeDouble(MartiLayer(0)*Point,3),3)+" Point"

        +" \n                                         Lowest Lots        : "+" "+DoubleToStr(NormalizeDouble(Lots_00,2),2)+" Lot"
        +" \n                                         Highest Lots        : "+" "+DoubleToStr(NormalizeDouble(LastHighestLots,2),2)+" Lot"
        +" \n.                                        Total LotsBuy       : "+" "+DoubleToString(NormalizeDouble(TotalLots(0),2),2)+" Lots"
        +" \n.                                        Total LotsSell       : "+" "+DoubleToString(NormalizeDouble(TotalLots(1),2),2)+" Lots"
        +" \n                                         Max. Ranges       : "+" "+DoubleToStr(NormalizeDouble(MaxRange(),0),0)+" Point"
     +" \n                                         Max. Lots in Ranges       : "+" "+DoubleToStr(NormalizeDouble( AccumulationLots(),2),2)+" Lots"
        +" \n                                         ==============================="
        +" \n                                         Price BEP Buy                            : "+" "+DoubleToString(NormalizeDouble(BEPBuy(),_Digits),Digits)+" Point"
        +" \n                                         Point TP Buy by Daily Target[%]  : "+" "+DoubleToString(NormalizeDouble(Point_TP_Partial_Percent_Buy(),Digits),Digits)+" Point"
        +" \n                                         Price TP Buy by Daily Target[%]  : "+" "+DoubleToString(NormalizeDouble(TP_Partial_Percent_Buy(),Digits),Digits)+" Point"
        +" \n                                         Point TP Buy by Dollar Target[$]  : "+" "+DoubleToString(NormalizeDouble(Point_TP_Dollar_Buy(),Digits),Digits)+" Point"
        +" \n                                         Price TP Buy by Dollar Target[$]  : "+" "+DoubleToString(NormalizeDouble(TP_Dollar_Buy(),Digits),Digits)+" Point"
        
        +" \n                                         Point SL Buy by Risk Balance [$]         : "+" "+DoubleToString(NormalizeDouble(Point_SL_Buy(),Digits),Digits)+" Point"
        +" \n                                         Price SL Buy by Risk Balance [$]         : "+" "+DoubleToString(NormalizeDouble(SL_Buy(),Digits),Digits)+" Point"
        +" \n                                         Price MC Buy by Risk Balance [$]         : "+" "+DoubleToString(NormalizeDouble( Price_MC_Buy() ,Digits),3)+" Point"
     
        +" \n                                         "
        +" \n                                         Price BEP Sell                            : "+" "+DoubleToString(NormalizeDouble(BEPSell(),Digits),Digits)+" Point"
        +" \n                                         Point TP Sell by Daily Target[%]  : "+" "+DoubleToString(NormalizeDouble(Point_TP_Percent_Sell(),Digits),Digits)+" Point"
        +" \n                                         Price TP Sell by Daily Target[%]  : "+" "+DoubleToString(NormalizeDouble(TP_Percent_Sell(),Digits),Digits)+" Point"
        +" \n                                         Point TP Sell by Dollar Target[$]  : "+" "+DoubleToString(NormalizeDouble(Point_TP_Dollar_Sell(),Digits),Digits)+" Point"
        +" \n                                         Price TP Sell by Dollar Target[$]  : "+" "+DoubleToString(NormalizeDouble(TP_Dollar_Sell(),Digits),Digits)+" Point"

        +" \n                                         Point SL Sell by Risk Balance [$]         : "+" "+DoubleToString(NormalizeDouble(Point_SL_Sell(),Digits),3)+" Point"
        +" \n                                         Price SL Sell by Risk Balance [$]         : "+" "+DoubleToString(NormalizeDouble(SL_Sell(),Digits),3)+" Point"
        +" \n                                         Price MC Sell by Risk Balance [$]         : "+" "+DoubleToString(NormalizeDouble( Price_MC_Sell() ,Digits),3)+" Point"
        +" \n                                         "
        +" \n                                     *** Calculate Profit From History [$]         : "+" "+DoubleToString(NormalizeDouble( CalculateTotalProfit() ,Digits),2)+" Dollar's ***"

        +" \n                                         ==============================="
       
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(BalUse_00,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_01,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_02,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_03,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_04,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_05,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_06,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_07,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_08,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_09,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_10,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(BalUse_11,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_12,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_13,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_14,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_15,2),2)
        
        +"+"+DoubleToStr(NormalizeDouble(BalUse_16,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_17,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_18,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_19,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_20,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(BalUse_21,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_22,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_23,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_24,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_25,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_26,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_27,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_28,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_29,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_30,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(BalUse_31,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_32,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_33,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_34,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_35,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_36,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_37,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_38,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_39,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_40,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(BalUse_41,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_42,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_43,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_44,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_45,2),2)
        
        +"+"+DoubleToStr(NormalizeDouble(BalUse_46,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_47,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_48,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_49,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_50,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(BalUse_51,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_52,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_53,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_54,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_55,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_56,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_57,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_58,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_59,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_60,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(BalUse_61,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_62,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_63,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_64,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_65,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_66,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_67,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_68,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_69,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_70,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(BalUse_71,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_72,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_73,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_74,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_75,2),2)
        
        +"+"+DoubleToStr(NormalizeDouble(BalUse_76,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_77,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_78,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_79,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_80,2),2)
        +" \n                                         "
        +"+"+DoubleToStr(NormalizeDouble(BalUse_81,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_82,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_83,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_84,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_85,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_86,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_87,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_88,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_89,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_90,2),2)
        +" \n                                         "
        +"+"+DoubleToStr(NormalizeDouble(BalUse_91,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_92,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_93,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_94,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_95,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_96,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_97,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_98,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_99,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_100,2),2)
        +"+"+DoubleToStr(NormalizeDouble(BalUse_101,2),2)
        
        +" \n                                         "
        +" \n                                         Lots Detail :  "
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(Lots_00,3),3)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(Lots_01,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_02,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_03,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_04,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_05,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_06,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_07,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_08,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_09,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_10,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(Lots_11,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_12,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_13,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_14,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_15,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_16,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_17,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_18,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_19,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_20,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(Lots_21,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_22,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_23,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_24,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_25,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_26,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_27,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_28,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_29,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_30,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(Lots_31,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_32,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_33,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_34,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_35,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_36,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_37,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_38,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_39,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_40,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(Lots_41,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_42,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_43,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_44,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_45,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_46,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_47,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_48,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_49,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_50,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(Lots_51,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_52,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_53,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_54,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_55,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_56,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_57,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_58,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_59,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_60,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(Lots_61,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_62,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_63,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_64,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_65,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_66,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_67,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_68,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_69,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_70,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(Lots_71,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_72,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_73,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_74,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_75,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_76,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_77,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_78,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_79,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_80,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(Lots_81,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_82,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_83,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_84,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_85,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_86,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_87,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_88,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_89,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_90,2),2)
        +" \n                                        "
        +"+"+DoubleToStr(NormalizeDouble(Lots_91,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_92,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_93,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_94,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_95,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_96,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_97,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_98,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_99,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_100,2),2)
        +"+"+DoubleToStr(NormalizeDouble(Lots_101,2),2)
        +" \n                                        "
        +" time : " + TimeToString(CalculateTimeFirstOpenOrders(),TIME_DATE|TIME_MINUTES)
        +" \n                                         ==============================="
        +" \n                                         Software Compound Lots Management"
        +" \n                                         Don't forget to Donate Some Coffee for Me  "
        +" \n                                         DOGE : DBHcaGRQBPhGb6kw1KxhHubPi4cZYsKhc6  "
        +" \n                                         This EA Will Help You to Calculate- "
        +" \n                                         Automatically Your Lots Management. "
        +" \n                                         Copyright 28 April 2022, Achmad Chaerul Rizal"
        +" \n                                         Kab. Tangerang, Banten, Indonesia"
        +" \n                                         gandewafx@gmail.com"
        +" \n                                         EA GANDEWA FX "
        +" \n                                         ==============================="
        ;               
   Comment(text);

return;
}



//--count Orders Positions
int ctd() {
   int c = 0;
   for (int ct = OrdersTotal() - 1; ct >= 0; ct--) {
      int os=OrderSelect(ct, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != Magic) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic)
         if (OrderType() == OP_SELL || OrderType() == OP_BUY) c++;
   }
   return (c);
}

//--Open Orders Functions

//               tiket = OpenPendingOrder(1, MartiLot, BidPrice, slip, BidPrice, 0, 0, NamaEA + "-" + counter, Magic, 0, HotPink);
int OpenOrder(int tipe, double a_lots, double a_price, int a_slippage, double a_TrailBidAsk, int a_trailprice_sl, int a_trailprice_tp, string a_comment, int a_magic, int a_datetime, color a_color) {
   int a_ticket = 0;
   int i_error = 0;
   int x = 0;
   int li_72 = 100;
   switch (tipe) {
   case 2:
      for (x = 0; x < li_72; x++) {
         a_ticket = OrderSend(Symbol(), OP_BUYLIMIT, a_lots, a_price, a_slippage, StopLong(a_TrailBidAsk, a_trailprice_sl), TakeLong(a_price, a_trailprice_tp), a_comment, a_magic, a_datetime, a_color);
         i_error = GetLastError();
         if (i_error == 0/* NO_ERROR */) break;
         if (!(i_error == 4/* SERVER_BUSY */ || i_error == 137/* BROKER_BUSY */ || i_error == 146/* TRADE_CONTEXT_BUSY */ || i_error == 136/* OFF_QUOTES */)) break;
         Sleep(1000);
      }
      break;
   case 4:
      for (x = 0; x < li_72; x++) {
         a_ticket = OrderSend(Symbol(), OP_BUYSTOP, a_lots, a_price, a_slippage, StopLong(a_TrailBidAsk, a_trailprice_sl), TakeLong(a_price, a_trailprice_tp), a_comment, a_magic, a_datetime, a_color);
         i_error = GetLastError();
         if (i_error == 0/* NO_ERROR */) break;
         if (!(i_error == 4/* SERVER_BUSY */ || i_error == 137/* BROKER_BUSY */ || i_error == 146/* TRADE_CONTEXT_BUSY */ || i_error == 136/* OFF_QUOTES */)) break;
         Sleep(5000);
      }
      break;
   case 0:
      for (x = 0; x < li_72; x++) {
         RefreshRates();
         a_ticket = OrderSend(Symbol(), OP_BUY, a_lots, Ask, a_slippage, StopLong(Bid, a_trailprice_sl), TakeLong(Ask, a_trailprice_tp), a_comment, a_magic, a_datetime, a_color);
         i_error = GetLastError();
         if (i_error == 0/* NO_ERROR */) break;
         if (!(i_error == 4/* SERVER_BUSY */ || i_error == 137/* BROKER_BUSY */ || i_error == 146/* TRADE_CONTEXT_BUSY */ || i_error == 136/* OFF_QUOTES */)) break;
         Sleep(5000);
      }
      break;
   case 3:
      for (x = 0; x < li_72; x++) {
         a_ticket = OrderSend(Symbol(), OP_SELLLIMIT, a_lots, a_price, a_slippage, StopShort(a_TrailBidAsk, a_trailprice_sl), TakeShort(a_price, a_trailprice_tp), a_comment, a_magic, a_datetime, a_color);
         i_error = GetLastError();
         if (i_error == 0/* NO_ERROR */) break;
         if (!(i_error == 4/* SERVER_BUSY */ || i_error == 137/* BROKER_BUSY */ || i_error == 146/* TRADE_CONTEXT_BUSY */ || i_error == 136/* OFF_QUOTES */)) break;
         Sleep(5000);
      }
      break;
   case 5:
      for (x = 0; x < li_72; x++) {
         a_ticket = OrderSend(Symbol(), OP_SELLSTOP, a_lots, a_price, a_slippage, StopShort(a_TrailBidAsk, a_trailprice_sl), TakeShort(a_price, a_trailprice_tp), a_comment, a_magic, a_datetime, a_color);
         i_error = GetLastError();
         if (i_error == 0/* NO_ERROR */) break;
         if (!(i_error == 4/* SERVER_BUSY */ || i_error == 137/* BROKER_BUSY */ || i_error == 146/* TRADE_CONTEXT_BUSY */ || i_error == 136/* OFF_QUOTES */)) break;
         Sleep(5000);
      }
      break;
   case 1:
      for (x = 0; x < li_72; x++) {
         a_ticket = OrderSend(Symbol(), OP_SELL, a_lots, Bid, a_slippage, StopShort(Ask, a_trailprice_sl), TakeShort(Bid, a_trailprice_tp), a_comment, a_magic, a_datetime, a_color);
         i_error = GetLastError();
         if (i_error == 0/* NO_ERROR */) break;
         if (!(i_error == 4/* SERVER_BUSY */ || i_error == 137/* BROKER_BUSY */ || i_error == 146/* TRADE_CONTEXT_BUSY */ || i_error == 136/* OFF_QUOTES */)) break;
         Sleep(5000);
      }
   }
   return (a_ticket);
}

double StopLong(double ad_TrailingBidAsk, int ad_tpsl) {
   if (ad_tpsl == 0) return (0);
   return (ad_TrailingBidAsk - ad_tpsl * Point);
}

double StopShort(double ad_TrailingBidAsk, int ad_tpsl) {
   if (ad_tpsl == 0) return (0);
   return (ad_TrailingBidAsk + ad_tpsl * Point);
}

double TakeLong(double ad_TrailingBidAsk, int ad_tpsl) {
   if (ad_tpsl == 0) return (0);
   return (ad_TrailingBidAsk + ad_tpsl * Point);
}

double TakeShort(double ad_TrailingBidAsk, int ad_tpsl) {
   if (ad_tpsl == 0) return (0);
   return (ad_TrailingBidAsk - ad_tpsl * Point);
}

double SumLots(int tipe){
double L=0;double lt=0;
   for(int i=0; i<OrdersTotal(); i++) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic && OrderType()==tipe){

if( Post(tipe)>0 && Post(tipe)<=NumLines 
 ){
L+= NormalizeDouble(OrderLots(),2);}
}
}
}
lt=L;
return (lt);
}


double RangeStep(int tipe){
double R=0;double r=0;
double spread = 0;

   for(int i=0; i<OrdersTotal(); i++) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic && OrderType()==tipe){

if( Post(tipe)>0 && Post(tipe)<=NumLines 
 ){
R= NormalizeDouble(((MaxRange()*MultipleRange)/NumLines),0);}
}
}
}r=R;
return (r);
}

double MartiLayer( int tipe) { 
double div =0;
double x = 0;

double layer=0;
   for(int i=0; i<OrdersTotal(); i++) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic && OrderType()==tipe){

  // double 
   div = Post(tipe) / GroupLayer;
  // double
    x = Post(tipe) - (div * GroupLayer);
    layer =RangeStep(tipe)*10;//NormalizeDouble(RangeStep(tipe)*MathPow(MultiLayer,x),0);
 
}}}  // double 


   return(layer);
   }      

int lotDigit() {
   int digit = 0;
   double mini = MarketInfo(Symbol(),MODE_MINLOT);
   if(mini == 0.01) digit = 2;
   if(mini == 0.1)  digit = 1;
   if(mini == 1)    digit = 0;
   return (digit);
}
/*
double Allocation (){

double My_Allocation=0;
double My_Allocation=InitialAllocation;
double RasioMaxLots=0;
RasioMaxLots=AccountBalance()*(InitialRasioMaxLots/100);
if (My_Allocation > RasioMaxLots) IncreaseAllocationLots-= 0.0001;
if (My_Allocation < RasioMaxLots) IncreaseAllocationLots+= 0.0001;
*/
/*
// Find The Correct Multiplier from The BalanceToTrade
My_Multiple_Lots=My_InitialMultiple_Lots;
if (BalanceToTrade>=Sum_Balance && My_Multiple_Lots>0)
Mpx+= 0.0001;
else if (BalanceToTrade<Sum_Balance && My_Multiple_Lots>0) 
Mpx-= 0.0001;
 My_Multiple_Lots= My_InitialMultiple_Lots+Mpx;
 
 }
 
 */
double Martilot(int tipe)
{
double l=0,lots=0; 
   for(int i=0; i<OrdersTotal(); i++) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic && OrderType()==tipe){

      if(UseMyBalance==TRUE) Balance = NormalizeDouble(AccountBalance()*(MyBalance/100),2);
      if(UseMyBalance==FALSE) Balance = NormalizeDouble(AccountBalance(),2);
      BalanceToTrade = NormalizeDouble((Balance * (Allocation()/100)),2);
      Diff_MaxLots = NormalizeDouble(MaxRange()/BalanceToTrade,10);

Bal_1 = 100 ; val_diff_1 = 0.0150; multiple_val_1 = 1.006968;
Bal_2 = 1503.75 ; val_diff_2 =0.00997505; multiple_val_2 = 1.0170077 ;
Bal_3 = 2261.27 ; val_diff_3 = 0.006633437; multiple_val_3 = 1.0258116 ;
Bal_4 = 3400.39 ; val_diff_4 =0.004411256 ; multiple_val_4 =1.03376511  ;
Bal_5 =  5113.34 ; val_diff_5 = 0.002933499 ; multiple_val_5 = 1.0411138 ;
Bal_6 = 7689.20 ; val_diff_6 = 0.001950786 ; multiple_val_6 = 1.04801993 ;
Bal_7 = 11562.66 ; val_diff_7 = 0.001297279 ; multiple_val_7 = 1.05459453 ;
Bal_8 =  17387.38 ; val_diff_8 =0.00086269441  ; multiple_val_8 =1.06091585  ;
Bal_9 =  26146.32 ; val_diff_9 =0.000573694  ; multiple_val_9 =1.06704048  ;
Bal_10 = 39317.59 ; val_diff_10 =0.000381509  ; multiple_val_10 = 1.073010255 ;
Bal_11 = 59123.92 ; val_diff_11 =0.00025370441  ; multiple_val_11 =1.078856712  ;
Bal_12 = 88907.74 ; val_diff_12 = 0.000168714 ; multiple_val_12 =1.084604036  ;
Bal_13 = 133695.22 ; val_diff_13 =0.000112195  ; multiple_val_13 = 1.090271073 ;
Bal_14 = 201044.51 ; val_diff_14 = 0.000074610 ; multiple_val_14 = 1.0958727165 ;
Bal_15 = 302321.16 ; val_diff_15 = 0.00004961611; multiple_val_15 = 1.1014208895 ;
Bal_16 = 454616.16 ; val_diff_16 = 0.00003299487; multiple_val_16 = 1.106925259 ;
Bal_17 = 683630.14 ; val_diff_17 = 0; multiple_val_17 = 0;

if(BalanceToTrade>Bal_1 && BalanceToTrade<=Bal_2 && AutoCalc==TRUE)
{
 DfL_01_00 = val_diff_1;
 Multiple = multiple_val_1;
} 
else
if(BalanceToTrade>Bal_2 && BalanceToTrade<= Bal_3 && AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_2;
 Multiple = multiple_val_2;
} 
else
if(BalanceToTrade>Bal_3 && BalanceToTrade<= Bal_4&& AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_3;
 Multiple = multiple_val_3;
} 
else
if(BalanceToTrade>Bal_4 && BalanceToTrade<= Bal_5 && AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_4;
 Multiple = multiple_val_4;
} 
else
if(BalanceToTrade>Bal_5 && BalanceToTrade<= Bal_6 && AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_5;
 Multiple = multiple_val_5;
} 
else
if(BalanceToTrade> Bal_6 && BalanceToTrade<= Bal_7 && AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_6;
 Multiple = multiple_val_6;
} 
else
if(BalanceToTrade>  Bal_7&& BalanceToTrade<= Bal_8 && AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_7;
 Multiple = multiple_val_7;
} 
else
if(BalanceToTrade> Bal_8 && BalanceToTrade<= Bal_9 && AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_8;
 Multiple = multiple_val_8;
} 
else
if(BalanceToTrade> Bal_9 && BalanceToTrade<= Bal_10 && AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_9;
 Multiple = multiple_val_9;
} 
else
if(BalanceToTrade> Bal_10 && BalanceToTrade<= Bal_11 && AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_10;
 Multiple = multiple_val_10;
} 
else
if(BalanceToTrade> Bal_11 && BalanceToTrade<= Bal_12 && AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_11;
 Multiple = multiple_val_11;
} 
else
if(BalanceToTrade> Bal_12 && BalanceToTrade<= Bal_13 && AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_12;
 Multiple = multiple_val_12;
} 
else
if(BalanceToTrade> Bal_13 && BalanceToTrade<= Bal_14 && AutoCalc==TRUE)
{
 DfL_01_00 =val_diff_13;
 Multiple = multiple_val_13;
} 
else
if(BalanceToTrade> Bal_14 && BalanceToTrade<= Bal_15 && AutoCalc==TRUE)
{
 DfL_01_00 = val_diff_14 ;
 Multiple = multiple_val_14 ;
} 
else
if(BalanceToTrade> Bal_15 && BalanceToTrade<= Bal_16 && AutoCalc==TRUE)
{
 DfL_01_00 = val_diff_15 ;
 Multiple = multiple_val_15 ;
} 
else
if(BalanceToTrade> Bal_16 && BalanceToTrade<= Bal_17 && AutoCalc==TRUE)
{
 DfL_01_00 = val_diff_16 ;
 Multiple = multiple_val_16 ;
} 
/*
else
if(BalanceToTrade> Bal_ && BalanceToTrade<= Bal_ && AutoCalc==TRUE)
{
 v_01_00 = val_diff_ ;
 Multiple = multiple_val_ ;
} 
*/
else
if(BalanceToTrade>100  && AutoCalc==FALSE)
{
 DfL_01_00 =NormalizeDouble(Diff_MaxLots/100,10);
 Multiple = My_Multiple_Lots;
}

 DfL_01_01 =DfL_01_00*Multiple;
 DfL_01_02 =DfL_01_01*Multiple;
 DfL_01_03 =DfL_01_02*Multiple;
 DfL_01_04 =DfL_01_03*Multiple;
 DfL_01_05 =DfL_01_04*Multiple;
 DfL_01_06 =DfL_01_05*Multiple;
 DfL_01_07 =DfL_01_06*Multiple;
 DfL_01_08 =DfL_01_07*Multiple;
 DfL_01_09 =DfL_01_08*Multiple;
 DfL_01_10 =DfL_01_09*Multiple;
 DfL_01_11 =DfL_01_10*Multiple;
 DfL_01_12 =DfL_01_11*Multiple;
 DfL_01_13 =DfL_01_12*Multiple;
 DfL_01_14 =DfL_01_13*Multiple;
 DfL_01_15 =DfL_01_14*Multiple;
 DfL_01_16 =DfL_01_15*Multiple;
 DfL_01_17 =DfL_01_16*Multiple;
 DfL_01_18 =DfL_01_17*Multiple;
 DfL_01_19 =DfL_01_18*Multiple;
 DfL_01_20 =DfL_01_19*Multiple;
 DfL_01_21 =DfL_01_20*Multiple;
 DfL_01_22 =DfL_01_21*Multiple; 
 DfL_01_23 =DfL_01_22*Multiple;
 DfL_01_24 =DfL_01_23*Multiple;
 DfL_01_25 =DfL_01_24*Multiple;
 DfL_01_26 =DfL_01_25*Multiple; 
 DfL_01_27 =DfL_01_26*Multiple;
 DfL_01_28 =DfL_01_27*Multiple;
 DfL_01_29 =DfL_01_28*Multiple;
 DfL_01_30 =DfL_01_29*Multiple; 
 DfL_01_31 =DfL_01_30*Multiple;
 DfL_01_32 =DfL_01_31*Multiple;
 DfL_01_33 =DfL_01_32*Multiple;
 DfL_01_34 =DfL_01_33*Multiple; 
 DfL_01_35 =DfL_01_34*Multiple;
 DfL_01_36 =DfL_01_35*Multiple;
 DfL_01_37 =DfL_01_36*Multiple;
 DfL_01_38 =DfL_01_37*Multiple; 
 DfL_01_39 =DfL_01_38*Multiple;
 DfL_01_40 =DfL_01_39*Multiple;
 DfL_01_41 =DfL_01_40*Multiple;
 DfL_01_42 =DfL_01_41*Multiple; 
 DfL_01_43 =DfL_01_42*Multiple;
 DfL_01_44 =DfL_01_43*Multiple;
 DfL_01_45 =DfL_01_44*Multiple;
 DfL_01_46 =DfL_01_45*Multiple; 
 DfL_01_47 =DfL_01_46*Multiple;
 DfL_01_48 =DfL_01_47*Multiple;
 DfL_01_49 =DfL_01_48*Multiple;
 DfL_01_50 =DfL_01_49*Multiple; 
 DfL_01_51 =DfL_01_50*Multiple;
 DfL_01_52 =DfL_01_51*Multiple;
 DfL_01_53 =DfL_01_52*Multiple;
 DfL_01_54 =DfL_01_53*Multiple; 
 DfL_01_55 =DfL_01_54*Multiple;
 DfL_01_56 =DfL_01_55*Multiple;
 DfL_01_57 =DfL_01_56*Multiple;
 DfL_01_58 =DfL_01_57*Multiple; 
 DfL_01_59 =DfL_01_58*Multiple;
 DfL_01_60 =DfL_01_59*Multiple;
 DfL_01_61 =DfL_01_60*Multiple;
 DfL_01_62 =DfL_01_61*Multiple; 
 DfL_01_63 =DfL_01_62*Multiple;
 DfL_01_64 =DfL_01_63*Multiple;
 DfL_01_65 =DfL_01_64*Multiple;
 DfL_01_66 =DfL_01_65*Multiple; 
 DfL_01_67 =DfL_01_66*Multiple;
 DfL_01_68 =DfL_01_67*Multiple;
 DfL_01_69 =DfL_01_68*Multiple;
 DfL_01_70 =DfL_01_69*Multiple; 
 DfL_01_71 =DfL_01_70*Multiple;
 DfL_01_72 =DfL_01_71*Multiple;
 DfL_01_73 =DfL_01_72*Multiple;
 DfL_01_74 =DfL_01_73*Multiple; 
 DfL_01_75 =DfL_01_74*Multiple;
 DfL_01_76 =DfL_01_75*Multiple;
 DfL_01_77 =DfL_01_76*Multiple;
 DfL_01_78 =DfL_01_77*Multiple; 
 DfL_01_79 =DfL_01_78*Multiple;
 DfL_01_80 =DfL_01_79*Multiple;
 DfL_01_81 =DfL_01_80*Multiple;
 DfL_01_82 =DfL_01_81*Multiple; 
 DfL_01_83 =DfL_01_82*Multiple;
 DfL_01_84 =DfL_01_83*Multiple;
 DfL_01_85 =DfL_01_84*Multiple;
 DfL_01_86 =DfL_01_85*Multiple; 
 DfL_01_87 =DfL_01_86*Multiple;
 DfL_01_88 =DfL_01_87*Multiple;
 DfL_01_89 =DfL_01_88*Multiple;
 DfL_01_90 =DfL_01_89*Multiple; 
 DfL_01_91 =DfL_01_90*Multiple;
 DfL_01_92 =DfL_01_91*Multiple;
 DfL_01_93 =DfL_01_92*Multiple;
 DfL_01_94 =DfL_01_93*Multiple; 
 DfL_01_95 =DfL_01_94*Multiple;
 DfL_01_96 =DfL_01_95*Multiple;
 DfL_01_97 =DfL_01_96*Multiple;
 DfL_01_98 =DfL_01_97*Multiple; 
 DfL_01_99 =DfL_01_98*Multiple;
 DfL_01_100 =DfL_01_99*Multiple;
 DfL_01_101 =DfL_01_100*Multiple;
 DfL_01_102 =DfL_01_101*Multiple; 
 DfL_01_103 =DfL_01_102*Multiple;
 DfL_01_104 =DfL_01_103*Multiple;
 DfL_01_105 =DfL_01_104*Multiple;
 DfL_01_106 =DfL_01_105*Multiple; 
 DfL_01_107 =DfL_01_106*Multiple;
 DfL_01_108 =DfL_01_107*Multiple;
 DfL_01_109 =DfL_01_108*Multiple;
 DfL_01_110 =DfL_01_109*Multiple; 
 DfL_01_111 =DfL_01_110*Multiple;
 DfL_01_112 =DfL_01_111*Multiple;
 DfL_01_113 =DfL_01_112*Multiple;
 DfL_01_114 =DfL_01_113*Multiple; 
 DfL_01_115 =DfL_01_114*Multiple;
 DfL_01_116 =DfL_01_115*Multiple;
 DfL_01_117 =DfL_01_116*Multiple;
 DfL_01_118 =DfL_01_117*Multiple; 
 DfL_01_119 =DfL_01_118*Multiple;
 DfL_01_120 =DfL_01_119*Multiple;
 DfL_01_121 =DfL_01_120*Multiple;
 DfL_01_122 =DfL_01_121*Multiple; 
 DfL_01_123 =DfL_01_122*Multiple;
 DfL_01_124 =DfL_01_123*Multiple;
 DfL_01_125 =DfL_01_124*Multiple;
 DfL_01_126 =DfL_01_125*Multiple; 
 DfL_01_127 =DfL_01_126*Multiple;
 DfL_01_128 =DfL_01_127*Multiple;
 DfL_01_129 =DfL_01_128*Multiple;
 DfL_01_130 =DfL_01_129*Multiple; 
 DfL_01_131 =DfL_01_130*Multiple;
 DfL_01_132 =DfL_01_131*Multiple;
 DfL_01_133 =DfL_01_132*Multiple;
 DfL_01_134 =DfL_01_133*Multiple; 
 DfL_01_135 =DfL_01_134*Multiple;
 DfL_01_136 =DfL_01_135*Multiple;
 DfL_01_137 =DfL_01_136*Multiple;
 DfL_01_138 =DfL_01_137*Multiple; 
 DfL_01_139 =DfL_01_138*Multiple;
 DfL_01_140 =DfL_01_139*Multiple;
 DfL_01_141 =DfL_01_140*Multiple;
 DfL_01_142 =DfL_01_141*Multiple; 
 DfL_01_143 =DfL_01_142*Multiple;
 DfL_01_144 =DfL_01_143*Multiple;
 DfL_01_145 =DfL_01_144*Multiple;
 DfL_01_146 =DfL_01_145*Multiple; 
 DfL_01_147 =DfL_01_146*Multiple;
 DfL_01_148 =DfL_01_147*Multiple;
 DfL_01_149 =DfL_01_148*Multiple;
 DfL_01_150 =DfL_01_149*Multiple; 
 DfL_01_151 =DfL_01_150*Multiple;
 DfL_01_152 =DfL_01_151*Multiple;
 DfL_01_153 =DfL_01_152*Multiple;
 DfL_01_154 =DfL_01_153*Multiple; 
 DfL_01_155 =DfL_01_154*Multiple;
 DfL_01_156 =DfL_01_155*Multiple;
 DfL_01_157 =DfL_01_156*Multiple;
 DfL_01_158 =DfL_01_157*Multiple; 
 DfL_01_159 =DfL_01_158*Multiple;
 DfL_01_160 =DfL_01_159*Multiple;
 DfL_01_161 =DfL_01_160*Multiple;
 DfL_01_162 =DfL_01_161*Multiple; 
 DfL_01_163 =DfL_01_162*Multiple;
 DfL_01_164 =DfL_01_163*Multiple;
 DfL_01_165 =DfL_01_164*Multiple;
 DfL_01_166 =DfL_01_165*Multiple; 
 DfL_01_167 =DfL_01_166*Multiple;
 DfL_01_168 =DfL_01_167*Multiple;
 DfL_01_169 =DfL_01_168*Multiple;
 DfL_01_170 =DfL_01_169*Multiple; 
 DfL_01_171 =DfL_01_170*Multiple;
 DfL_01_172 =DfL_01_171*Multiple;
 DfL_01_173 =DfL_01_172*Multiple;
 DfL_01_174 =DfL_01_173*Multiple; 
 DfL_01_175 =DfL_01_174*Multiple;
 DfL_01_176 =DfL_01_175*Multiple;
 DfL_01_177 =DfL_01_176*Multiple;
 DfL_01_178 =DfL_01_177*Multiple; 
 DfL_01_179 =DfL_01_178*Multiple;
 DfL_01_180 =DfL_01_179*Multiple;
 DfL_01_181 =DfL_01_180*Multiple;
 DfL_01_182 =DfL_01_181*Multiple; 
 DfL_01_183 =DfL_01_182*Multiple;
 DfL_01_184 =DfL_01_183*Multiple;
 DfL_01_185 =DfL_01_184*Multiple;
 DfL_01_186 =DfL_01_185*Multiple; 
 DfL_01_187 =DfL_01_186*Multiple;
 DfL_01_188 =DfL_01_187*Multiple;
 DfL_01_189 =DfL_01_188*Multiple;
 DfL_01_190 =DfL_01_189*Multiple; 
 DfL_01_191 =DfL_01_190*Multiple;
 DfL_01_192 =DfL_01_191*Multiple;
 DfL_01_193 =DfL_01_192*Multiple;
 DfL_01_194 =DfL_01_193*Multiple; 
 DfL_01_195 =DfL_01_194*Multiple;
 DfL_01_196 =DfL_01_195*Multiple;
 DfL_01_197 =DfL_01_196*Multiple;
 DfL_01_198 =DfL_01_197*Multiple; 
 DfL_01_199 =DfL_01_198*Multiple;
 DfL_01_200 =DfL_01_199*Multiple;
 DfL_01_201 =DfL_01_200*Multiple;
 
 Lots_00 = NormalizeDouble(DfL_01_00/Diff_MaxLots,3);
 Lots_01 = NormalizeDouble(DfL_01_01/Diff_MaxLots,2);
 Lots_02 = NormalizeDouble(DfL_01_02/Diff_MaxLots,2);
 Lots_03 = NormalizeDouble(DfL_01_03/Diff_MaxLots,2);
 Lots_04 = NormalizeDouble(DfL_01_04/Diff_MaxLots,2);
 Lots_05 = NormalizeDouble(DfL_01_05/Diff_MaxLots,2);
 Lots_06 = NormalizeDouble(DfL_01_06/Diff_MaxLots,2);
 Lots_07 = NormalizeDouble(DfL_01_07/Diff_MaxLots,2);
 Lots_08 = NormalizeDouble(DfL_01_08/Diff_MaxLots,2);
 Lots_09 = NormalizeDouble(DfL_01_09/Diff_MaxLots,2);
 Lots_10 = NormalizeDouble(DfL_01_10/Diff_MaxLots,2);
 Lots_11 = NormalizeDouble(DfL_01_11/Diff_MaxLots,2);
 Lots_12 = NormalizeDouble(DfL_01_12/Diff_MaxLots,2);
 Lots_13 = NormalizeDouble(DfL_01_13/Diff_MaxLots,2);
 Lots_14 = NormalizeDouble(DfL_01_14/Diff_MaxLots,2);
 Lots_15 = NormalizeDouble(DfL_01_15/Diff_MaxLots,2);
 Lots_16 = NormalizeDouble(DfL_01_16/Diff_MaxLots,2);
 Lots_17 = NormalizeDouble(DfL_01_17/Diff_MaxLots,2);
 Lots_18 = NormalizeDouble(DfL_01_18/Diff_MaxLots,2);
 Lots_19 = NormalizeDouble(DfL_01_19/Diff_MaxLots,2);
 Lots_20 = NormalizeDouble(DfL_01_20/Diff_MaxLots,2);
 Lots_21 = NormalizeDouble(DfL_01_21/Diff_MaxLots,2);
 Lots_22 = NormalizeDouble(DfL_01_22/Diff_MaxLots,2);
 Lots_23 = NormalizeDouble(DfL_01_23/Diff_MaxLots,2);
 Lots_24 = NormalizeDouble(DfL_01_24/Diff_MaxLots,2);
 Lots_25 = NormalizeDouble(DfL_01_25/Diff_MaxLots,2);
 Lots_26 = NormalizeDouble(DfL_01_26/Diff_MaxLots,2);
 Lots_27 = NormalizeDouble(DfL_01_27/Diff_MaxLots,2);
 Lots_28 = NormalizeDouble(DfL_01_28/Diff_MaxLots,2);
 Lots_29 = NormalizeDouble(DfL_01_29/Diff_MaxLots,2);
 Lots_30 = NormalizeDouble(DfL_01_30/Diff_MaxLots,2);
 Lots_31 = NormalizeDouble(DfL_01_31/Diff_MaxLots,2);
 Lots_32 = NormalizeDouble(DfL_01_32/Diff_MaxLots,2);
 Lots_33 = NormalizeDouble(DfL_01_33/Diff_MaxLots,2);
 Lots_34 = NormalizeDouble(DfL_01_34/Diff_MaxLots,2);
 Lots_35 = NormalizeDouble(DfL_01_35/Diff_MaxLots,2);
 Lots_36 = NormalizeDouble(DfL_01_36/Diff_MaxLots,2);
 Lots_37 = NormalizeDouble(DfL_01_37/Diff_MaxLots,2);
 Lots_38 = NormalizeDouble(DfL_01_38/Diff_MaxLots,2);
 Lots_39 = NormalizeDouble(DfL_01_39/Diff_MaxLots,2);
 Lots_40 = NormalizeDouble(DfL_01_40/Diff_MaxLots,2);
 Lots_41 = NormalizeDouble(DfL_01_41/Diff_MaxLots,2);
 Lots_42 = NormalizeDouble(DfL_01_42/Diff_MaxLots,2);
 Lots_43 = NormalizeDouble(DfL_01_43/Diff_MaxLots,2);
 Lots_44 = NormalizeDouble(DfL_01_44/Diff_MaxLots,2);
 Lots_45 = NormalizeDouble(DfL_01_45/Diff_MaxLots,2);
 Lots_46 = NormalizeDouble(DfL_01_46/Diff_MaxLots,2);
 Lots_47 = NormalizeDouble(DfL_01_47/Diff_MaxLots,2);
 Lots_48 = NormalizeDouble(DfL_01_48/Diff_MaxLots,2);
 Lots_49 = NormalizeDouble(DfL_01_49/Diff_MaxLots,2);
 Lots_50 = NormalizeDouble(DfL_01_50/Diff_MaxLots,2);
 Lots_51 = NormalizeDouble(DfL_01_51/Diff_MaxLots,2);
 Lots_52 = NormalizeDouble(DfL_01_52/Diff_MaxLots,2);
 Lots_53 = NormalizeDouble(DfL_01_53/Diff_MaxLots,2);
 Lots_54 = NormalizeDouble(DfL_01_54/Diff_MaxLots,2);
 Lots_55 = NormalizeDouble(DfL_01_55/Diff_MaxLots,2);
 Lots_56 = NormalizeDouble(DfL_01_56/Diff_MaxLots,2);
 Lots_57 = NormalizeDouble(DfL_01_57/Diff_MaxLots,2);
 Lots_58 = NormalizeDouble(DfL_01_58/Diff_MaxLots,2);
 Lots_59 = NormalizeDouble(DfL_01_59/Diff_MaxLots,2);
 Lots_60 = NormalizeDouble(DfL_01_60/Diff_MaxLots,2);
 Lots_61 = NormalizeDouble(DfL_01_61/Diff_MaxLots,2);
 Lots_62 = NormalizeDouble(DfL_01_62/Diff_MaxLots,2);
 Lots_63 = NormalizeDouble(DfL_01_63/Diff_MaxLots,2);
 Lots_64 = NormalizeDouble(DfL_01_64/Diff_MaxLots,2);
 Lots_65 = NormalizeDouble(DfL_01_65/Diff_MaxLots,2);
 Lots_66 = NormalizeDouble(DfL_01_66/Diff_MaxLots,2);
 Lots_67 = NormalizeDouble(DfL_01_67/Diff_MaxLots,2);
 Lots_68 = NormalizeDouble(DfL_01_68/Diff_MaxLots,2);
 Lots_69 = NormalizeDouble(DfL_01_69/Diff_MaxLots,2);
 Lots_70 = NormalizeDouble(DfL_01_70/Diff_MaxLots,2);
 Lots_71 = NormalizeDouble(DfL_01_71/Diff_MaxLots,2);
 Lots_72 = NormalizeDouble(DfL_01_72/Diff_MaxLots,2);
 Lots_73 = NormalizeDouble(DfL_01_73/Diff_MaxLots,2);
 Lots_74 = NormalizeDouble(DfL_01_74/Diff_MaxLots,2);
 Lots_75 = NormalizeDouble(DfL_01_75/Diff_MaxLots,2);
 Lots_76 = NormalizeDouble(DfL_01_76/Diff_MaxLots,2);
 Lots_77 = NormalizeDouble(DfL_01_77/Diff_MaxLots,2);
 Lots_78 = NormalizeDouble(DfL_01_78/Diff_MaxLots,2);
 Lots_79 = NormalizeDouble(DfL_01_79/Diff_MaxLots,2);
 Lots_80 = NormalizeDouble(DfL_01_80/Diff_MaxLots,2);
 Lots_81 = NormalizeDouble(DfL_01_81/Diff_MaxLots,2);
 Lots_82 = NormalizeDouble(DfL_01_82/Diff_MaxLots,2);
 Lots_83 = NormalizeDouble(DfL_01_83/Diff_MaxLots,2);
 Lots_84 = NormalizeDouble(DfL_01_84/Diff_MaxLots,2);
 Lots_85 = NormalizeDouble(DfL_01_85/Diff_MaxLots,2);
 Lots_86 = NormalizeDouble(DfL_01_86/Diff_MaxLots,2);
 Lots_87 = NormalizeDouble(DfL_01_87/Diff_MaxLots,2);
 Lots_88 = NormalizeDouble(DfL_01_88/Diff_MaxLots,2);
 Lots_89 = NormalizeDouble(DfL_01_89/Diff_MaxLots,2);
 Lots_90 = NormalizeDouble(DfL_01_90/Diff_MaxLots,2);
 Lots_91 = NormalizeDouble(DfL_01_91/Diff_MaxLots,2);
 Lots_92 = NormalizeDouble(DfL_01_92/Diff_MaxLots,2);
 Lots_93 = NormalizeDouble(DfL_01_93/Diff_MaxLots,2);
 Lots_94 = NormalizeDouble(DfL_01_94/Diff_MaxLots,2);
 Lots_95 = NormalizeDouble(DfL_01_95/Diff_MaxLots,2);
 Lots_96 = NormalizeDouble(DfL_01_96/Diff_MaxLots,2);
 Lots_97 = NormalizeDouble(DfL_01_97/Diff_MaxLots,2);
 Lots_98 = NormalizeDouble(DfL_01_98/Diff_MaxLots,2);
 Lots_99 = NormalizeDouble(DfL_01_99/Diff_MaxLots,2);
 Lots_100 =NormalizeDouble( DfL_01_100/Diff_MaxLots,2);
 Lots_101 =NormalizeDouble( DfL_01_101/Diff_MaxLots,2);
 Lots_102 = NormalizeDouble(DfL_01_102/Diff_MaxLots,2);
 Lots_103 = NormalizeDouble(DfL_01_103/Diff_MaxLots,2);
 Lots_104 = NormalizeDouble(DfL_01_104/Diff_MaxLots,2);
 Lots_105 = NormalizeDouble(DfL_01_105/Diff_MaxLots,2);
 Lots_106 = NormalizeDouble(DfL_01_106/Diff_MaxLots,2);
 Lots_107 = NormalizeDouble(DfL_01_107/Diff_MaxLots,2);
 Lots_108 = NormalizeDouble(DfL_01_108/Diff_MaxLots,2);
 Lots_109 = NormalizeDouble(DfL_01_109/Diff_MaxLots,2);
 Lots_110 = NormalizeDouble(DfL_01_110/Diff_MaxLots,2);
 Lots_111 = NormalizeDouble(DfL_01_111/Diff_MaxLots,2);
 Lots_112 = NormalizeDouble(DfL_01_112/Diff_MaxLots,2);
 Lots_113 = NormalizeDouble(DfL_01_113/Diff_MaxLots,2);
 Lots_114 = NormalizeDouble(DfL_01_114/Diff_MaxLots,2);
 Lots_115 = NormalizeDouble(DfL_01_115/Diff_MaxLots,2);
 Lots_116 = NormalizeDouble(DfL_01_116/Diff_MaxLots,2);
 Lots_117 = NormalizeDouble(DfL_01_117/Diff_MaxLots,2);
 Lots_118 = NormalizeDouble(DfL_01_118/Diff_MaxLots,2);
 Lots_119 = NormalizeDouble(DfL_01_119/Diff_MaxLots,2);
 Lots_120 = NormalizeDouble(DfL_01_120/Diff_MaxLots,2);
 Lots_121 = NormalizeDouble(DfL_01_121/Diff_MaxLots,2);
 Lots_122 = NormalizeDouble(DfL_01_122/Diff_MaxLots,2);
 Lots_123 = NormalizeDouble(DfL_01_123/Diff_MaxLots,2);
 Lots_124 = NormalizeDouble(DfL_01_124/Diff_MaxLots,2);
 Lots_125 = NormalizeDouble(DfL_01_125/Diff_MaxLots,2);
 Lots_126 = NormalizeDouble(DfL_01_126/Diff_MaxLots,2);
 Lots_127 = NormalizeDouble(DfL_01_127/Diff_MaxLots,2);
 Lots_128 = NormalizeDouble(DfL_01_128/Diff_MaxLots,2);
 Lots_129 = NormalizeDouble(DfL_01_129/Diff_MaxLots,2);
 Lots_130 = NormalizeDouble(DfL_01_130/Diff_MaxLots,2);
 Lots_131 = NormalizeDouble(DfL_01_131/Diff_MaxLots,2);
 Lots_132 = NormalizeDouble(DfL_01_132/Diff_MaxLots,2);
 Lots_133 = NormalizeDouble(DfL_01_133/Diff_MaxLots,2);
 Lots_134 = NormalizeDouble(DfL_01_134/Diff_MaxLots,2);
 Lots_135 = NormalizeDouble(DfL_01_135/Diff_MaxLots,2);
 Lots_136 = NormalizeDouble(DfL_01_136/Diff_MaxLots,2);
 Lots_137 = NormalizeDouble(DfL_01_137/Diff_MaxLots,2);
 Lots_138 = NormalizeDouble(DfL_01_138/Diff_MaxLots,2);
 Lots_139 = NormalizeDouble(DfL_01_139/Diff_MaxLots,2);
 Lots_140 = NormalizeDouble(DfL_01_140/Diff_MaxLots,2);
 Lots_141 = NormalizeDouble(DfL_01_141/Diff_MaxLots,2);
 Lots_142 = NormalizeDouble(DfL_01_142/Diff_MaxLots,2);
 Lots_143 = NormalizeDouble(DfL_01_143/Diff_MaxLots,2);
 Lots_144 = NormalizeDouble(DfL_01_144/Diff_MaxLots,2);
 Lots_145 = NormalizeDouble(DfL_01_145/Diff_MaxLots,2);
 Lots_146 = NormalizeDouble(DfL_01_146/Diff_MaxLots,2);
 Lots_147 = NormalizeDouble(DfL_01_147/Diff_MaxLots,2);
 Lots_148 = NormalizeDouble(DfL_01_148/Diff_MaxLots,2);
 Lots_149 = NormalizeDouble(DfL_01_149/Diff_MaxLots,2);
 Lots_150 = NormalizeDouble(DfL_01_150/Diff_MaxLots,2);
 Lots_151 = NormalizeDouble(DfL_01_151/Diff_MaxLots,2);
 Lots_152 = NormalizeDouble(DfL_01_152/Diff_MaxLots,2);
 Lots_153 = NormalizeDouble(DfL_01_153/Diff_MaxLots,2);
 Lots_154 = NormalizeDouble(DfL_01_154/Diff_MaxLots,2);
 Lots_155 = NormalizeDouble(DfL_01_155/Diff_MaxLots,2);
 Lots_156 = NormalizeDouble(DfL_01_156/Diff_MaxLots,2);
 Lots_157 = NormalizeDouble(DfL_01_157/Diff_MaxLots,2);
 Lots_158 = NormalizeDouble(DfL_01_158/Diff_MaxLots,2);
 Lots_159 = NormalizeDouble(DfL_01_159/Diff_MaxLots,2);
 Lots_160 = NormalizeDouble(DfL_01_160/Diff_MaxLots,2);
 Lots_161 = NormalizeDouble(DfL_01_161/Diff_MaxLots,2);
 Lots_162 = NormalizeDouble(DfL_01_162/Diff_MaxLots,2);
 Lots_163 = NormalizeDouble(DfL_01_163/Diff_MaxLots,2);
 Lots_164 = NormalizeDouble(DfL_01_164/Diff_MaxLots,2);
 Lots_165 = NormalizeDouble(DfL_01_165/Diff_MaxLots,2);
 Lots_166 = NormalizeDouble(DfL_01_166/Diff_MaxLots,2);
 Lots_167 = NormalizeDouble(DfL_01_167/Diff_MaxLots,2);
 Lots_168 = NormalizeDouble(DfL_01_168/Diff_MaxLots,2);
 Lots_169 = NormalizeDouble(DfL_01_169/Diff_MaxLots,2);
 Lots_170 = NormalizeDouble(DfL_01_170/Diff_MaxLots,2);
 Lots_171 = NormalizeDouble(DfL_01_171/Diff_MaxLots,2);
 Lots_172 = NormalizeDouble(DfL_01_172/Diff_MaxLots,2);
 Lots_173 = NormalizeDouble(DfL_01_173/Diff_MaxLots,2);
 Lots_174 = NormalizeDouble(DfL_01_174/Diff_MaxLots,2);
 Lots_175 = NormalizeDouble(DfL_01_175/Diff_MaxLots,2);
 Lots_176 = NormalizeDouble(DfL_01_176/Diff_MaxLots,2);
 Lots_177 = NormalizeDouble(DfL_01_177/Diff_MaxLots,2);
 Lots_178 = NormalizeDouble(DfL_01_178/Diff_MaxLots,2);
 Lots_179 = NormalizeDouble(DfL_01_179/Diff_MaxLots,2);
 Lots_180 = NormalizeDouble(DfL_01_180/Diff_MaxLots,2);
 Lots_181 = NormalizeDouble(DfL_01_181/Diff_MaxLots,2);
 Lots_182 = NormalizeDouble(DfL_01_182/Diff_MaxLots,2);
 Lots_183 = NormalizeDouble(DfL_01_183/Diff_MaxLots,2);
 Lots_184 = NormalizeDouble(DfL_01_184/Diff_MaxLots,2);
 Lots_185 = NormalizeDouble(DfL_01_185/Diff_MaxLots,2);
 Lots_186 = NormalizeDouble(DfL_01_186/Diff_MaxLots,2);
 Lots_187 = NormalizeDouble(DfL_01_187/Diff_MaxLots,2);
 Lots_188 = NormalizeDouble(DfL_01_188/Diff_MaxLots,2);
 Lots_189 = NormalizeDouble(DfL_01_189/Diff_MaxLots,2);
 Lots_190 = NormalizeDouble(DfL_01_190/Diff_MaxLots,2);
 Lots_191 = NormalizeDouble(DfL_01_191/Diff_MaxLots,2);
 Lots_192 = NormalizeDouble(DfL_01_192/Diff_MaxLots,2);
 Lots_193 = NormalizeDouble(DfL_01_193/Diff_MaxLots,2);
 Lots_194 = NormalizeDouble(DfL_01_194/Diff_MaxLots,2);
 Lots_195 = NormalizeDouble(DfL_01_195/Diff_MaxLots,2);
 Lots_196 = NormalizeDouble(DfL_01_196/Diff_MaxLots,2);
 Lots_197 = NormalizeDouble(DfL_01_197/Diff_MaxLots,2);
 Lots_198 = NormalizeDouble(DfL_01_198/Diff_MaxLots,2);
 Lots_199 = NormalizeDouble(DfL_01_199/Diff_MaxLots,2);
 Lots_200 = NormalizeDouble(DfL_01_200/Diff_MaxLots,2);
 Lots_201 = NormalizeDouble(DfL_01_201/Diff_MaxLots,2);
 
 RTT_00 = MaxRange();
 RTT_01 = RTT_00 - Spacing();
 RTT_02 = RTT_01 - Spacing();
 RTT_03 = RTT_02 - Spacing();
 RTT_04 = RTT_03 - Spacing();
 RTT_05 = RTT_04 - Spacing();
 RTT_06 = RTT_05 - Spacing();
 RTT_07 = RTT_06 - Spacing();
 RTT_08 = RTT_07 - Spacing();
 RTT_09 = RTT_08 - Spacing();
 RTT_10 = RTT_09 - Spacing();
 RTT_11 = RTT_10 - Spacing();
 RTT_12 = RTT_11 - Spacing();
 RTT_13 = RTT_12 - Spacing();
 RTT_14 = RTT_13 - Spacing();
 RTT_15 = RTT_14 - Spacing();
 RTT_16 = RTT_15 - Spacing();
 RTT_17 = RTT_16 - Spacing();
 RTT_18 = RTT_17 - Spacing();
 RTT_19 = RTT_18 - Spacing();
 RTT_20 = RTT_19 - Spacing();
 RTT_21 = RTT_20 - Spacing();
 RTT_22 = RTT_21 - Spacing();
 RTT_23 = RTT_22 - Spacing();
 RTT_24 = RTT_23 - Spacing();
 RTT_25 = RTT_24 - Spacing();
 RTT_26 = RTT_25 - Spacing();
 RTT_27 = RTT_26 - Spacing();
 RTT_28 = RTT_27 - Spacing();
 RTT_29 = RTT_28 - Spacing();
 RTT_30 = RTT_29 - Spacing();
 RTT_31 = RTT_30 - Spacing();
 RTT_32 = RTT_31 - Spacing();
 RTT_33 = RTT_32 - Spacing();
 RTT_34 = RTT_33 - Spacing();
 RTT_35 = RTT_34 - Spacing();
 RTT_36 = RTT_35 - Spacing();
 RTT_37 = RTT_36 - Spacing();
 RTT_38 = RTT_37 - Spacing();
 RTT_39 = RTT_38 - Spacing();
 RTT_40 = RTT_39 - Spacing();
 RTT_41 = RTT_40 - Spacing();
 RTT_42 = RTT_41 - Spacing();
 RTT_43 = RTT_42 - Spacing();
 RTT_44 = RTT_43 - Spacing();
 RTT_45 = RTT_44 - Spacing();
 RTT_46 = RTT_45 - Spacing();
 RTT_47 = RTT_46 - Spacing();
 RTT_48 = RTT_47 - Spacing();
 RTT_49 = RTT_48 - Spacing();
 RTT_50 = RTT_49 - Spacing();
 RTT_51 = RTT_50 - Spacing();
 RTT_52 = RTT_51 - Spacing();
 RTT_53 = RTT_52 - Spacing();
 RTT_54 = RTT_53 - Spacing();
 RTT_55 = RTT_54 - Spacing();
 RTT_56 = RTT_55 - Spacing();
 RTT_57 = RTT_56 - Spacing();
 RTT_58 = RTT_57 - Spacing();
 RTT_59 = RTT_58 - Spacing();
 RTT_60 = RTT_59 - Spacing();
 RTT_61 = RTT_60 - Spacing();
 RTT_62 = RTT_61 - Spacing();
 RTT_63 = RTT_62 - Spacing();
 RTT_64 = RTT_63 - Spacing();
 RTT_65 = RTT_64 - Spacing();
 RTT_66 = RTT_65 - Spacing();
 RTT_67 = RTT_66 - Spacing();
 RTT_68 = RTT_67 - Spacing();
 RTT_69 = RTT_68 - Spacing();
 RTT_70 = RTT_69 - Spacing();
 RTT_71 = RTT_70 - Spacing();
 RTT_72 = RTT_71 - Spacing();
 RTT_73 = RTT_72 - Spacing();
 RTT_74 = RTT_73 - Spacing();
 RTT_75 = RTT_74 - Spacing();
 RTT_76 = RTT_75 - Spacing();
 RTT_77 = RTT_76 - Spacing();
 RTT_78 = RTT_77 - Spacing();
 RTT_79 = RTT_78 - Spacing();
 RTT_80 = RTT_79 - Spacing();
 RTT_81 = RTT_80 - Spacing();
 RTT_82 = RTT_81 - Spacing();
 RTT_83 = RTT_82 - Spacing();
 RTT_84 = RTT_83 - Spacing();
 RTT_85 = RTT_84 - Spacing();
 RTT_86 = RTT_85 - Spacing();
 RTT_87 = RTT_86 - Spacing();
 RTT_88 = RTT_87 - Spacing();
 RTT_89 = RTT_88 - Spacing();
 RTT_90 = RTT_89 - Spacing();
 RTT_91 = RTT_90 - Spacing();
 RTT_92 = RTT_91 - Spacing();
 RTT_93 = RTT_92 - Spacing();
 RTT_94 = RTT_93 - Spacing();
 RTT_95 = RTT_94 - Spacing();
 RTT_96 = RTT_95 - Spacing();
 RTT_97 = RTT_96 - Spacing();
 RTT_98 = RTT_97 - Spacing();
 RTT_99 = RTT_98 - Spacing();
 RTT_100 = RTT_99 - Spacing();
 RTT_101 = RTT_100 - Spacing();
 RTT_102 = RTT_101 - Spacing();
 RTT_103 = RTT_102 - Spacing();
 RTT_104 = RTT_103 - Spacing();
 RTT_105 = RTT_104 - Spacing();
 RTT_106 = RTT_105 - Spacing();
 RTT_107 = RTT_106 - Spacing();
 RTT_108 = RTT_107 - Spacing();
 RTT_109 = RTT_108 - Spacing();
 RTT_110 = RTT_109 - Spacing();
 RTT_111 = RTT_110 - Spacing();
 RTT_112 = RTT_111 - Spacing();
 RTT_113 = RTT_112 - Spacing();
 RTT_114 = RTT_113 - Spacing();
 RTT_115 = RTT_114 - Spacing();
 RTT_116 = RTT_115 - Spacing();
 RTT_117 = RTT_116 - Spacing();
 RTT_118 = RTT_117 - Spacing();
 RTT_119 = RTT_118 - Spacing();
 RTT_120 = RTT_119 - Spacing();
 RTT_121 = RTT_120 - Spacing();
 RTT_122 = RTT_121 - Spacing();
 RTT_123 = RTT_122 - Spacing();
 RTT_124 = RTT_123 - Spacing();
 RTT_125 = RTT_124 - Spacing();
 RTT_126 = RTT_125 - Spacing();
 RTT_127 = RTT_126 - Spacing();
 RTT_128 = RTT_127 - Spacing();
 RTT_129 = RTT_128 - Spacing();
 RTT_130 = RTT_129 - Spacing();
 RTT_131 = RTT_130 - Spacing();
 RTT_132 = RTT_131 - Spacing();
 RTT_133 = RTT_132 - Spacing();
 RTT_134 = RTT_133 - Spacing();
 RTT_135 = RTT_134 - Spacing();
 RTT_136 = RTT_135 - Spacing();
 RTT_137 = RTT_136 - Spacing();
 RTT_138 = RTT_137 - Spacing();
 RTT_139 = RTT_138 - Spacing();
 RTT_140 = RTT_139 - Spacing();
 RTT_141 = RTT_140 - Spacing();
 RTT_142 = RTT_141 - Spacing();
 RTT_143 = RTT_142 - Spacing();
 RTT_144 = RTT_143 - Spacing();
 RTT_145 = RTT_144 - Spacing();
 RTT_146 = RTT_145 - Spacing();
 RTT_147 = RTT_146 - Spacing();
 RTT_148 = RTT_147 - Spacing();
 RTT_149 = RTT_148 - Spacing();
 RTT_150 = RTT_149 - Spacing();
 RTT_151 = RTT_150 - Spacing();
 RTT_152 = RTT_151 - Spacing();
 RTT_153 = RTT_152 - Spacing();
 RTT_154 = RTT_153 - Spacing();
 RTT_155 = RTT_154 - Spacing();
 RTT_156 = RTT_155 - Spacing();
 RTT_157 = RTT_156 - Spacing();
 RTT_158 = RTT_157 - Spacing();
 RTT_159 = RTT_158 - Spacing();
 RTT_160 = RTT_159 - Spacing();
 RTT_161 = RTT_160 - Spacing();
 RTT_162 = RTT_161 - Spacing();
 RTT_163 = RTT_162 - Spacing();
 RTT_164 = RTT_163 - Spacing();
 RTT_165 = RTT_164 - Spacing();
 RTT_166 = RTT_165 - Spacing();
 RTT_167 = RTT_166 - Spacing();
 RTT_168 = RTT_167 - Spacing();
 RTT_169 = RTT_168 - Spacing();
 RTT_170 = RTT_169 - Spacing();
 RTT_171 = RTT_170 - Spacing();
 RTT_172 = RTT_171 - Spacing();
 RTT_173 = RTT_172 - Spacing();
 RTT_174 = RTT_173 - Spacing();
 RTT_175 = RTT_174 - Spacing();
 RTT_176 = RTT_175 - Spacing();
 RTT_177 = RTT_176 - Spacing();
 RTT_178 = RTT_177 - Spacing();
 RTT_179 = RTT_178 - Spacing();
 RTT_180 = RTT_179 - Spacing();
 RTT_181 = RTT_180 - Spacing();
 RTT_182 = RTT_181 - Spacing();
 RTT_183 = RTT_182 - Spacing();
 RTT_184 = RTT_183 - Spacing();
 RTT_185 = RTT_184 - Spacing();
 RTT_186 = RTT_185 - Spacing();
 RTT_187 = RTT_186 - Spacing();
 RTT_188 = RTT_187 - Spacing();
 RTT_189 = RTT_188 - Spacing();
 RTT_190 = RTT_189 - Spacing();
 RTT_191 = RTT_190 - Spacing();
 RTT_192 = RTT_191 - Spacing();
 RTT_193 = RTT_192 - Spacing();
 RTT_194 = RTT_193 - Spacing();
 RTT_195 = RTT_194 - Spacing();
 RTT_196 = RTT_195 - Spacing();
 RTT_197 = RTT_196 - Spacing();
 RTT_198 = RTT_197 - Spacing();
 RTT_199 = RTT_198 - Spacing();
 RTT_200 = RTT_199 - Spacing();
 RTT_201 = RTT_200 - Spacing(); 
//----------------------------------------------------------------------------------//
//                        FIND A HIGHEST LOTS ON CICLES                             //
//----------------------------------------------------------------------------------//
 if( RTT_00<=Spacing()&&  Lots_00 <= 0.005)lots = 0.00;
 if( RTT_01<=Spacing()&&  Lots_01 <= 0.00)lots = 0.00;
 if( RTT_02<=Spacing()&&  Lots_02 <= 0.00)lots = 0.00;
 if( RTT_03<=Spacing()&&  Lots_03 <= 0.00)lots = 0.00;
 if( RTT_04<=Spacing()&&  Lots_04 <= 0.00)lots = 0.00;
 if( RTT_05<=Spacing()&&  Lots_05 <= 0.00)lots = 0.00;
 if( RTT_06<=Spacing()&&  Lots_06 <= 0.00)lots = 0.00;
 if( RTT_07<=Spacing()&&  Lots_07 <= 0.00)lots = 0.00;
 if( RTT_08<=Spacing()&&  Lots_08 <= 0.00)lots = 0.00;
 if( RTT_09<=Spacing()&&  Lots_09 <= 0.00)lots = 0.00;
 if( RTT_10<=Spacing()&&  Lots_10 <= 0.00)lots = 0.00;
 if( RTT_11<=Spacing()&&  Lots_11 <= 0.00)lots = 0.00;
 if( RTT_12<=Spacing()&&  Lots_12 <= 0.00)lots = 0.00;
 if( RTT_13<=Spacing()&&  Lots_13 <= 0.00)lots = 0.00;
 if( RTT_14<=Spacing()&&  Lots_14 <= 0.00)lots = 0.00;
 if( RTT_15<=Spacing()&&  Lots_15 <= 0.00)lots = 0.00;
 if( RTT_16<=Spacing()&&  Lots_16 <= 0.00)lots = 0.00;
 if( RTT_17<=Spacing()&&  Lots_17 <= 0.00)lots = 0.00;
 if( RTT_18<=Spacing()&&  Lots_18 <= 0.00)lots = 0.00;
 if( RTT_19<=Spacing()&&  Lots_19 <= 0.00)lots = 0.00;
 if( RTT_20<=Spacing()&&  Lots_20 <= 0.00)lots = 0.00;
 if( RTT_21<=Spacing()&&  Lots_21 <= 0.00)lots = 0.00;
 if( RTT_22<=Spacing()&&  Lots_22 <= 0.00)lots = 0.00;
 if( RTT_23<=Spacing()&&  Lots_23 <= 0.00)lots = 0.00;
 if( RTT_24<=Spacing()&&  Lots_24 <= 0.00)lots = 0.00;
 if(  RTT_25<=Spacing()&&  Lots_25 <= 0.00)lots = 0.00;
 if(  RTT_26<=Spacing()&&  Lots_26 <= 0.00)lots = 0.00;
 if(  RTT_27<=Spacing()&&  Lots_27 <= 0.00)lots = 0.00;
 if(  RTT_28<=Spacing()&&  Lots_28 <= 0.00)lots = 0.00;
 if(  RTT_29<=Spacing()&&  Lots_29 <= 0.00)lots = 0.00;
 if(  RTT_30<=Spacing()&&  Lots_30 <= 0.00)lots = 0.00;
 if(  RTT_31<=Spacing()&&  Lots_31 <= 0.00)lots = 0.00;
 if(  RTT_32<=Spacing()&&  Lots_32 <= 0.00)lots = 0.00;
 if(  RTT_33<=Spacing()&&  Lots_33 <= 0.00)lots = 0.00;
 if(  RTT_34<=Spacing()&&  Lots_34 <= 0.00)lots = 0.00;
 if(  RTT_35<=Spacing()&&  Lots_35 <= 0.00)lots = 0.00;
 if(  RTT_36<=Spacing()&&  Lots_36 <= 0.00)lots = 0.00;
 if(  RTT_37<=Spacing()&&  Lots_37 <= 0.00)lots = 0.00;
 if(  RTT_38<=Spacing()&&  Lots_38 <= 0.00)lots = 0.00;
 if(  RTT_39<=Spacing()&&  Lots_39 <= 0.00)lots = 0.00;
 if(  RTT_40<=Spacing()&&  Lots_40 <= 0.00)lots = 0.00;
 if(  RTT_41<=Spacing()&&  Lots_41 <= 0.00)lots = 0.00;
 if(  RTT_42<=Spacing()&&  Lots_42 <= 0.00)lots = 0.00;
 if(  RTT_43<=Spacing()&&  Lots_43 <= 0.00)lots = 0.00;
 if(  RTT_44<=Spacing()&&  Lots_44 <= 0.00)lots = 0.00;
 if(  RTT_45<=Spacing()&&  Lots_45 <= 0.00)lots = 0.00;
 if(  RTT_46<=Spacing()&&  Lots_46 <= 0.00)lots = 0.00;
 if(  RTT_47<=Spacing()&&  Lots_47 <= 0.00)lots = 0.00;
 if(  RTT_48<=Spacing()&&  Lots_48 <= 0.00)lots = 0.00;
 if(  RTT_49<=Spacing()&&  Lots_49 <= 0.00)lots = 0.00;
 if(  RTT_50<=Spacing()&&  Lots_50 <= 0.00)lots = 0.00;
 if(  RTT_51<=Spacing()&&  Lots_51 <= 0.00)lots = 0.00;
 if(  RTT_52<=Spacing()&&  Lots_52 <= 0.00)lots = 0.00;
 if(  RTT_53<=Spacing()&&  Lots_53 <= 0.00)lots = 0.00;
 if(  RTT_54<=Spacing()&&  Lots_54 <= 0.00)lots = 0.00;
 if(  RTT_55<=Spacing()&&  Lots_55 <= 0.00)lots = 0.00;
 if(  RTT_56<=Spacing()&&  Lots_56 <= 0.00)lots = 0.00;
 if(  RTT_57<=Spacing()&&  Lots_57 <= 0.00)lots = 0.00;
 if(  RTT_58<=Spacing()&&  Lots_58 <= 0.00)lots = 0.00;
 if(  RTT_59<=Spacing()&&  Lots_59 <= 0.00)lots = 0.00;
 if(  RTT_60<=Spacing()&&  Lots_60 <= 0.00)lots = 0.00;
 if(  RTT_61<=Spacing()&&  Lots_61 <= 0.00)lots = 0.00;
 if(  RTT_62<=Spacing()&&  Lots_62 <= 0.00)lots = 0.00;
 if(  RTT_63<=Spacing()&&  Lots_63 <= 0.00)lots = 0.00;
 if(  RTT_64<=Spacing()&&  Lots_64 <= 0.00)lots = 0.00;
 if(  RTT_65<=Spacing()&&  Lots_65 <= 0.00)lots = 0.00;
 if(  RTT_66<=Spacing()&&  Lots_66 <= 0.00)lots = 0.00;
 if(  RTT_67<=Spacing()&&  Lots_67 <= 0.00)lots = 0.00;
 if(  RTT_68<=Spacing()&&  Lots_68 <= 0.00)lots = 0.00;
 if(  RTT_69<=Spacing()&&  Lots_69 <= 0.00)lots = 0.00;
 if(  RTT_70<=Spacing()&&  Lots_70 <= 0.00)lots = 0.00;
 if(  RTT_71<=Spacing()&&  Lots_71 <= 0.00)lots = 0.00;
 if(  RTT_72<=Spacing()&&  Lots_72 <= 0.00)lots = 0.00;
 if(  RTT_73<=Spacing()&&  Lots_73 <= 0.00)lots = 0.00;
 if(  RTT_74<=Spacing()&&  Lots_74 <= 0.00)lots = 0.00;
 if(  RTT_75<=Spacing()&&  Lots_75 <= 0.00)lots = 0.00;
 if(  RTT_76<=Spacing()&&  Lots_76 <= 0.00)lots = 0.00;
 if(  RTT_77<=Spacing()&&  Lots_77 <= 0.00)lots = 0.00;
 if(  RTT_78<=Spacing()&&  Lots_78 <= 0.00)lots = 0.00;
 if(  RTT_79<=Spacing()&&  Lots_79 <= 0.00)lots = 0.00;
 if(  RTT_80<=Spacing()&&  Lots_80 <= 0.00)lots = 0.00;
 if(  RTT_81<=Spacing()&&  Lots_81 <= 0.00)lots = 0.00;
 if(  RTT_82<=Spacing()&&  Lots_82 <= 0.00)lots = 0.00;
 if(  RTT_83<=Spacing()&&  Lots_83 <= 0.00)lots = 0.00;
 if(  RTT_84<=Spacing()&&  Lots_84 <= 0.00)lots = 0.00;
 if(  RTT_85<=Spacing()&&  Lots_85 <= 0.00)lots = 0.00;
 if(  RTT_86<=Spacing()&&  Lots_86 <= 0.00)lots = 0.00;
 if(  RTT_87<=Spacing()&&  Lots_87 <= 0.00)lots = 0.00;
 if(  RTT_88<=Spacing()&&  Lots_88 <= 0.00)lots = 0.00;
 if(  RTT_89<=Spacing()&&  Lots_89 <= 0.00)lots = 0.00;
 if(  RTT_90<=Spacing()&&  Lots_90 <= 0.00)lots = 0.00;
 if(  RTT_91<=Spacing()&&  Lots_91 <= 0.00)lots = 0.00;
 if(  RTT_92<=Spacing()&&  Lots_92 <= 0.00)lots = 0.00;
 if(  RTT_93<=Spacing()&&  Lots_93 <= 0.00)lots = 0.00;
 if(  RTT_94<=Spacing()&&  Lots_94 <= 0.00)lots = 0.00;
 if(  RTT_95<=Spacing()&&  Lots_95 <= 0.00)lots = 0.00;
 if(  RTT_96<=Spacing()&&  Lots_96 <= 0.00)lots = 0.00;
 if(  RTT_97<=Spacing()&&  Lots_97 <= 0.00)lots = 0.00;
 if(  RTT_98<=Spacing()&&  Lots_98 <= 0.00)lots = 0.00;
 if(  RTT_99<=Spacing()&&  Lots_99 <= 0.00)lots = 0.00;
 if(  RTT_100<=Spacing()&&  Lots_100 <= 0.00)lots = 0.00;
 if(  RTT_101<=Spacing()&&  Lots_101 <= 0.00)lots = 0.00;
 if(  RTT_102<=Spacing()&&  Lots_102 <= 0.00)lots = 0.00;
 if(  RTT_103<=Spacing()&&  Lots_103 <= 0.00)lots = 0.00;
 if(  RTT_104<=Spacing()&&  Lots_104 <= 0.00)lots = 0.00;
 if(  RTT_105<=Spacing()&&  Lots_105 <= 0.00)lots = 0.00;
 if(  RTT_106<=Spacing()&&  Lots_106 <= 0.00)lots = 0.00;
 if(  RTT_107<=Spacing()&&  Lots_107 <= 0.00)lots = 0.00;
 if(  RTT_108<=Spacing()&&  Lots_108 <= 0.00)lots = 0.00;
 if(  RTT_109<=Spacing()&&  Lots_109 <= 0.00)lots = 0.00;
 if(  RTT_110<=Spacing()&&  Lots_110 <= 0.00)lots = 0.00;
 if(  RTT_111<=Spacing()&&  Lots_111 <= 0.00)lots = 0.00;
 if(  RTT_112<=Spacing()&&  Lots_112 <= 0.00)lots = 0.00;
 if(  RTT_113<=Spacing()&&  Lots_113 <= 0.00)lots = 0.00;
 if(  RTT_114<=Spacing()&&  Lots_114 <= 0.00)lots = 0.00;
 if(  RTT_115<=Spacing()&&  Lots_115 <= 0.00)lots = 0.00;
 if(  RTT_116<=Spacing()&&  Lots_116 <= 0.00)lots = 0.00;
 if(  RTT_117<=Spacing()&&  Lots_117 <= 0.00)lots = 0.00;
 if(  RTT_118<=Spacing()&&  Lots_118 <= 0.00)lots = 0.00;
 if(  RTT_119<=Spacing()&&  Lots_119 <= 0.00)lots = 0.00;
 if(  RTT_120<=Spacing()&&  Lots_120 <= 0.00)lots = 0.00;
 if(  RTT_121<=Spacing()&&  Lots_121 <= 0.00)lots = 0.00;
 if(  RTT_122<=Spacing()&&  Lots_122 <= 0.00)lots = 0.00;
 if(  RTT_123<=Spacing()&&  Lots_123 <= 0.00)lots = 0.00;
 if(  RTT_124<=Spacing()&&  Lots_124 <= 0.00)lots = 0.00;
 if(  RTT_125<=Spacing()&&  Lots_125 <= 0.00)lots = 0.00;
 if(  RTT_126<=Spacing()&&  Lots_126 <= 0.00)lots = 0.00;
 if(  RTT_127<=Spacing()&&  Lots_127 <= 0.00)lots = 0.00;
 if(  RTT_128<=Spacing()&&  Lots_128 <= 0.00)lots = 0.00;
 if(  RTT_129<=Spacing()&&  Lots_129 <= 0.00)lots = 0.00;
 if(  RTT_130<=Spacing()&&  Lots_130 <= 0.00)lots = 0.00;
 if(  RTT_131<=Spacing()&&  Lots_131 <= 0.00)lots = 0.00;
 if(  RTT_132<=Spacing()&&  Lots_132 <= 0.00)lots = 0.00;
 if(  RTT_133<=Spacing()&&  Lots_133 <= 0.00)lots = 0.00;
 if(  RTT_134<=Spacing()&&  Lots_134 <= 0.00)lots = 0.00;
 if(  RTT_135<=Spacing()&&  Lots_135 <= 0.00)lots = 0.00;
 if(  RTT_136<=Spacing()&&  Lots_136 <= 0.00)lots = 0.00;
 if(  RTT_137<=Spacing()&&  Lots_137 <= 0.00)lots = 0.00;
 if(  RTT_138<=Spacing()&&  Lots_138 <= 0.00)lots = 0.00;
 if(  RTT_139<=Spacing()&&  Lots_139 <= 0.00)lots = 0.00;
 if(  RTT_140<=Spacing()&&  Lots_140 <= 0.00)lots = 0.00;
 if(  RTT_141<=Spacing()&&  Lots_141 <= 0.00)lots = 0.00;
 if(  RTT_142<=Spacing()&&  Lots_142 <= 0.00)lots = 0.00;
 if(  RTT_143<=Spacing()&&  Lots_143 <= 0.00)lots = 0.00;
 if(  RTT_144<=Spacing()&&  Lots_144 <= 0.00)lots = 0.00;
 if(  RTT_145<=Spacing()&&  Lots_145 <= 0.00)lots = 0.00;
 if(  RTT_146<=Spacing()&&  Lots_146 <= 0.00)lots = 0.00;
 if(  RTT_147<=Spacing()&&  Lots_147 <= 0.00)lots = 0.00;
 if(  RTT_148<=Spacing()&&  Lots_148 <= 0.00)lots = 0.00;
 if(  RTT_149<=Spacing()&&  Lots_149 <= 0.00)lots = 0.00;
 if(  RTT_150<=Spacing()&&  Lots_150 <= 0.00)lots = 0.00;
 if(  RTT_151<=Spacing()&&  Lots_151 <= 0.00)lots = 0.00;
 if(  RTT_152<=Spacing()&&  Lots_152 <= 0.00)lots = 0.00;
 if(  RTT_153<=Spacing()&&  Lots_153 <= 0.00)lots = 0.00;
 if(  RTT_154<=Spacing()&&  Lots_154 <= 0.00)lots = 0.00;
 if(  RTT_155<=Spacing()&&  Lots_155 <= 0.00)lots = 0.00;
 if(  RTT_156<=Spacing()&&  Lots_156 <= 0.00)lots = 0.00;
 if(  RTT_157<=Spacing()&&  Lots_157 <= 0.00)lots = 0.00;
 if(  RTT_158<=Spacing()&&  Lots_158 <= 0.00)lots = 0.00;
 if(  RTT_159<=Spacing()&&  Lots_159 <= 0.00)lots = 0.00;
 if(  RTT_160<=Spacing()&&  Lots_160 <= 0.00)lots = 0.00;
 if(  RTT_161<=Spacing()&&  Lots_161 <= 0.00)lots = 0.00;
 if(  RTT_162<=Spacing()&&  Lots_162 <= 0.00)lots = 0.00;
 if(  RTT_163<=Spacing()&&  Lots_163 <= 0.00)lots = 0.00;
 if(  RTT_164<=Spacing()&&  Lots_164 <= 0.00)lots = 0.00;
 if(  RTT_165<=Spacing()&&  Lots_165 <= 0.00)lots = 0.00;
 if(  RTT_166<=Spacing()&&  Lots_166 <= 0.00)lots = 0.00;
 if(  RTT_167<=Spacing()&&  Lots_167 <= 0.00)lots = 0.00;
 if(  RTT_168<=Spacing()&&  Lots_168 <= 0.00)lots = 0.00;
 if(  RTT_169<=Spacing()&&  Lots_169 <= 0.00)lots = 0.00;
 if(  RTT_170<=Spacing()&&  Lots_170 <= 0.00)lots = 0.00;
 if(  RTT_171<=Spacing()&&  Lots_171 <= 0.00)lots = 0.00;
 if(  RTT_172<=Spacing()&&  Lots_172 <= 0.00)lots = 0.00;
 if(  RTT_173<=Spacing()&&  Lots_173 <= 0.00)lots = 0.00;
 if(  RTT_174<=Spacing()&&  Lots_174 <= 0.00)lots = 0.00;
 if(  RTT_175<=Spacing()&&  Lots_175 <= 0.00)lots = 0.00;
 if(  RTT_176<=Spacing()&&  Lots_176 <= 0.00)lots = 0.00;
 if(  RTT_177<=Spacing()&&  Lots_177 <= 0.00)lots = 0.00;
 if(  RTT_178<=Spacing()&&  Lots_178 <= 0.00)lots = 0.00;
 if(  RTT_179<=Spacing()&&  Lots_179 <= 0.00)lots = 0.00;
 if(  RTT_180<=Spacing()&&  Lots_180 <= 0.00)lots = 0.00;
 if(  RTT_181<=Spacing()&&  Lots_181 <= 0.00)lots = 0.00;
 if(  RTT_182<=Spacing()&&  Lots_182 <= 0.00)lots = 0.00;
 if(  RTT_183<=Spacing()&&  Lots_183 <= 0.00)lots = 0.00;
 if(  RTT_184<=Spacing()&&  Lots_184 <= 0.00)lots = 0.00;
 if(  RTT_185<=Spacing()&&  Lots_185 <= 0.00)lots = 0.00;
 if(  RTT_186<=Spacing()&&  Lots_186 <= 0.00)lots = 0.00;
 if(  RTT_187<=Spacing()&&  Lots_187 <= 0.00)lots = 0.00;
 if(  RTT_188<=Spacing()&&  Lots_188 <= 0.00)lots = 0.00;
 if(  RTT_189<=Spacing()&&  Lots_189 <= 0.00)lots = 0.00;
 if(  RTT_190<=Spacing()&&  Lots_190 <= 0.00)lots = 0.00;
 if(  RTT_191<=Spacing()&&  Lots_191 <= 0.00)lots = 0.00;
 if(  RTT_192<=Spacing()&&  Lots_192 <= 0.00)lots = 0.00;
 if(  RTT_193<=Spacing()&&  Lots_193 <= 0.00)lots = 0.00;
 if(  RTT_194<=Spacing()&&  Lots_194 <= 0.00)lots = 0.00;
 if(  RTT_195<=Spacing()&&  Lots_195 <= 0.00)lots = 0.00;
 if(  RTT_196<=Spacing()&&  Lots_196 <= 0.00)lots = 0.00;
 if(  RTT_197<=Spacing()&&  Lots_197 <= 0.00)lots = 0.00;
 if(  RTT_198<=Spacing()&&  Lots_198 <= 0.00)lots = 0.00;
 if(  RTT_199<=Spacing()&&  Lots_199 <= 0.00)lots = 0.00;
 if(  RTT_200<=Spacing()&&  Lots_200 <= 0.00)lots = 0.00;
 if(  RTT_201<=Spacing()&&  Lots_201 <= 0.00)lots = 0.00;

 if(RTT_00>Spacing()&& Lots_00>0.005)  lots = NormalizeDouble(Lots_00,2);
 if(RTT_01>Spacing())  lots = NormalizeDouble(Lots_01,2);
 if(RTT_02>Spacing())  lots = NormalizeDouble(Lots_02,2);
 if(RTT_03>Spacing())  lots = NormalizeDouble(Lots_03,2);
 if(RTT_04>Spacing())  lots = NormalizeDouble(Lots_04,2);
 if(RTT_05>Spacing())  lots = NormalizeDouble(Lots_05,2);
 if(RTT_06>Spacing())  lots = NormalizeDouble(Lots_06,2);
 if(RTT_07>Spacing())  lots = NormalizeDouble(Lots_07,2);
 if(RTT_08>Spacing())  lots = NormalizeDouble(Lots_08,2);
 if(RTT_09>Spacing())  lots = NormalizeDouble(Lots_09,2);
 if(RTT_10>Spacing())  lots = NormalizeDouble(Lots_10,2);
 if(RTT_11>Spacing())  lots = NormalizeDouble(Lots_11,2);
 if(RTT_12>Spacing())  lots = NormalizeDouble(Lots_12,2);
 if(RTT_13>Spacing())  lots = NormalizeDouble(Lots_13,2);
 if(RTT_14>Spacing())  lots = NormalizeDouble(Lots_14,2);
 if(RTT_15>Spacing())  lots = NormalizeDouble(Lots_15,2);
 if(RTT_16>Spacing())  lots = NormalizeDouble(Lots_16,2);
 if(RTT_17>Spacing())  lots = NormalizeDouble(Lots_17,2);
 if(RTT_18>Spacing())  lots = NormalizeDouble(Lots_18,2);
 if(RTT_19>Spacing())  lots = NormalizeDouble(Lots_19,2);
 if(RTT_20>Spacing())  lots = NormalizeDouble(Lots_20,2);
 if(RTT_21>Spacing())  lots = NormalizeDouble(Lots_21,2);
 if(RTT_22>Spacing())  lots = NormalizeDouble(Lots_22,2);
 if(RTT_23>Spacing())  lots = NormalizeDouble(Lots_23,2);
 if(RTT_24>Spacing())  lots = NormalizeDouble(Lots_24,2);
 if(RTT_25>Spacing())  lots = NormalizeDouble(Lots_25,2);
 if(RTT_26>Spacing())  lots = NormalizeDouble(Lots_26,2);
 if(RTT_27>Spacing())  lots = NormalizeDouble(Lots_27,2);
 if(RTT_28>Spacing())  lots = NormalizeDouble(Lots_28,2);
 if(RTT_29>Spacing())  lots = NormalizeDouble(Lots_29,2);
 if(RTT_30>Spacing())  lots = NormalizeDouble(Lots_30,2);
 if(RTT_31>Spacing())  lots = NormalizeDouble(Lots_31,2);
 if(RTT_32>Spacing())  lots = NormalizeDouble(Lots_32,2);
 if(RTT_33>Spacing())  lots = NormalizeDouble(Lots_33,2);
 if(RTT_34>Spacing())  lots = NormalizeDouble(Lots_34,2);
 if(RTT_35>Spacing())  lots = NormalizeDouble(Lots_35,2);
 if(RTT_36>Spacing())  lots = NormalizeDouble(Lots_36,2);
 if(RTT_37>Spacing())  lots = NormalizeDouble(Lots_37,2);
 if(RTT_38>Spacing())  lots = NormalizeDouble(Lots_38,2);
 if(RTT_39>Spacing())  lots = NormalizeDouble(Lots_39,2);
 if(RTT_40>Spacing())  lots = NormalizeDouble(Lots_40,2);
 if(RTT_41>Spacing())  lots = NormalizeDouble(Lots_41,2);
 if(RTT_42>Spacing())  lots = NormalizeDouble(Lots_42,2);
 if(RTT_43>Spacing())  lots = NormalizeDouble(Lots_43,2);
 if(RTT_44>Spacing())  lots = NormalizeDouble(Lots_44,2);
 if(RTT_45>Spacing())  lots = NormalizeDouble(Lots_45,2);
 if(RTT_46>Spacing())  lots = NormalizeDouble(Lots_46,2);
 if(RTT_47>Spacing())  lots = NormalizeDouble(Lots_47,2);
 if(RTT_48>Spacing())  lots = NormalizeDouble(Lots_48,2);
 if(RTT_49>Spacing())  lots = NormalizeDouble(Lots_49,2);
 if(RTT_50>Spacing())  lots = NormalizeDouble(Lots_50,2);
 if(RTT_51>Spacing())  lots = NormalizeDouble(Lots_51,2);
 if(RTT_52>Spacing())  lots = NormalizeDouble(Lots_52,2);
 if(RTT_53>Spacing())  lots = NormalizeDouble(Lots_53,2);
 if(RTT_54>Spacing())  lots = NormalizeDouble(Lots_54,2);
 if(RTT_55>Spacing())  lots = NormalizeDouble(Lots_55,2);
 if(RTT_56>Spacing())  lots = NormalizeDouble(Lots_56,2);
 if(RTT_57>Spacing())  lots = NormalizeDouble(Lots_57,2);
 if(RTT_58>Spacing())  lots = NormalizeDouble(Lots_58,2);
 if(RTT_59>Spacing())  lots = NormalizeDouble(Lots_59,2);
 if(RTT_60>Spacing())  lots = NormalizeDouble(Lots_60,2);
 if(RTT_61>Spacing())  lots = NormalizeDouble(Lots_61,2);
 if(RTT_62>Spacing())  lots = NormalizeDouble(Lots_62,2);
 if(RTT_63>Spacing())  lots = NormalizeDouble(Lots_63,2);
 if(RTT_64>Spacing())  lots = NormalizeDouble(Lots_64,2);
 if(RTT_65>Spacing())  lots = NormalizeDouble(Lots_65,2);
 if(RTT_66>Spacing())  lots = NormalizeDouble(Lots_66,2);
 if(RTT_67>Spacing())  lots = NormalizeDouble(Lots_67,2);
 if(RTT_68>Spacing())  lots = NormalizeDouble(Lots_68,2);
 if(RTT_69>Spacing())  lots = NormalizeDouble(Lots_69,2);
 if(RTT_70>Spacing())  lots = NormalizeDouble(Lots_70,2);
 if(RTT_71>Spacing())  lots = NormalizeDouble(Lots_71,2);
 if(RTT_72>Spacing())  lots = NormalizeDouble(Lots_72,2);
 if(RTT_73>Spacing())  lots = NormalizeDouble(Lots_73,2);
 if(RTT_74>Spacing())  lots = NormalizeDouble(Lots_74,2);
 if(RTT_75>Spacing())  lots = NormalizeDouble(Lots_75,2);
 if(RTT_76>Spacing())  lots = NormalizeDouble(Lots_76,2);
 if(RTT_77>Spacing())  lots = NormalizeDouble(Lots_77,2);
 if(RTT_78>Spacing())  lots = NormalizeDouble(Lots_78,2);
 if(RTT_79>Spacing())  lots = NormalizeDouble(Lots_79,2);
 if(RTT_80>Spacing())  lots = NormalizeDouble(Lots_80,2);
 if(RTT_81>Spacing())  lots = NormalizeDouble(Lots_81,2);
 if(RTT_82>Spacing())  lots = NormalizeDouble(Lots_82,2);
 if(RTT_83>Spacing())  lots = NormalizeDouble(Lots_83,2);
 if(RTT_84>Spacing())  lots = NormalizeDouble(Lots_84,2);
 if(RTT_85>Spacing())  lots = NormalizeDouble(Lots_85,2);
 if(RTT_86>Spacing())  lots = NormalizeDouble(Lots_86,2);
 if(RTT_87>Spacing())  lots = NormalizeDouble(Lots_87,2);
 if(RTT_88>Spacing())  lots = NormalizeDouble(Lots_88,2);
 if(RTT_89>Spacing())  lots = NormalizeDouble(Lots_89,2);
 if(RTT_90>Spacing())  lots = NormalizeDouble(Lots_90,2);
 if(RTT_91>Spacing())  lots = NormalizeDouble(Lots_91,2);
 if(RTT_92>Spacing())  lots = NormalizeDouble(Lots_92,2);
 if(RTT_93>Spacing())  lots = NormalizeDouble(Lots_93,2);
 if(RTT_94>Spacing())  lots = NormalizeDouble(Lots_94,2);
 if(RTT_95>Spacing())  lots = NormalizeDouble(Lots_95,2);
 if(RTT_96>Spacing())  lots = NormalizeDouble(Lots_96,2);
 if(RTT_97>Spacing())  lots = NormalizeDouble(Lots_97,2);
 if(RTT_98>Spacing())  lots = NormalizeDouble(Lots_98,2);
 if(RTT_99>Spacing())  lots = NormalizeDouble(Lots_99,2);
 if(RTT_100>Spacing())  lots = NormalizeDouble(Lots_100,2);
 if(RTT_101>Spacing())  lots = NormalizeDouble(Lots_101,2);
 if(RTT_102>Spacing())  lots = NormalizeDouble(Lots_102,2);
 if(RTT_103>Spacing())  lots = NormalizeDouble(Lots_103,2);
 if(RTT_104>Spacing())  lots = NormalizeDouble(Lots_104,2);
 if(RTT_105>Spacing())  lots = NormalizeDouble(Lots_105,2);
 if(RTT_106>Spacing())  lots = NormalizeDouble(Lots_106,2);
 if(RTT_107>Spacing())  lots = NormalizeDouble(Lots_107,2);
 if(RTT_108>Spacing())  lots = NormalizeDouble(Lots_108,2);
 if(RTT_109>Spacing())  lots = NormalizeDouble(Lots_109,2);
 if(RTT_110>Spacing())  lots = NormalizeDouble(Lots_110,2);
 if(RTT_111>Spacing())  lots = NormalizeDouble(Lots_111,2);
 if(RTT_112>Spacing())  lots = NormalizeDouble(Lots_112,2);
 if(RTT_113>Spacing())  lots = NormalizeDouble(Lots_113,2);
 if(RTT_114>Spacing())  lots = NormalizeDouble(Lots_114,2);
 if(RTT_115>Spacing())  lots = NormalizeDouble(Lots_115,2);
 if(RTT_116>Spacing())  lots = NormalizeDouble(Lots_116,2);
 if(RTT_117>Spacing())  lots = NormalizeDouble(Lots_117,2);
 if(RTT_118>Spacing())  lots = NormalizeDouble(Lots_118,2);
 if(RTT_119>Spacing())  lots = NormalizeDouble(Lots_119,2);
 if(RTT_120>Spacing())  lots = NormalizeDouble(Lots_120,2);
 if(RTT_121>Spacing())  lots = NormalizeDouble(Lots_121,2);
 if(RTT_122>Spacing())  lots = NormalizeDouble(Lots_122,2);
 if(RTT_123>Spacing())  lots = NormalizeDouble(Lots_123,2);
 if(RTT_124>Spacing())  lots = NormalizeDouble(Lots_124,2);
 if(RTT_125>Spacing())  lots = NormalizeDouble(Lots_125,2);
 if(RTT_126>Spacing())  lots = NormalizeDouble(Lots_126,2);
 if(RTT_127>Spacing())  lots = NormalizeDouble(Lots_127,2);
 if(RTT_128>Spacing())  lots = NormalizeDouble(Lots_128,2);
 if(RTT_129>Spacing())  lots = NormalizeDouble(Lots_129,2);
 if(RTT_130>Spacing())  lots = NormalizeDouble(Lots_130,2);
 if(RTT_131>Spacing())  lots = NormalizeDouble(Lots_131,2);
 if(RTT_132>Spacing())  lots = NormalizeDouble(Lots_132,2);
 if(RTT_133>Spacing())  lots = NormalizeDouble(Lots_133,2);
 if(RTT_134>Spacing())  lots = NormalizeDouble(Lots_134,2);
 if(RTT_135>Spacing())  lots = NormalizeDouble(Lots_135,2);
 if(RTT_136>Spacing())  lots = NormalizeDouble(Lots_136,2);
 if(RTT_137>Spacing())  lots = NormalizeDouble(Lots_137,2);
 if(RTT_138>Spacing())  lots = NormalizeDouble(Lots_138,2);
 if(RTT_139>Spacing())  lots = NormalizeDouble(Lots_139,2);
 if(RTT_140>Spacing())  lots = NormalizeDouble(Lots_140,2);
 if(RTT_141>Spacing())  lots = NormalizeDouble(Lots_141,2);
 if(RTT_142>Spacing())  lots = NormalizeDouble(Lots_142,2);
 if(RTT_143>Spacing())  lots = NormalizeDouble(Lots_143,2);
 if(RTT_144>Spacing())  lots = NormalizeDouble(Lots_144,2);
 if(RTT_145>Spacing())  lots = NormalizeDouble(Lots_145,2);
 if(RTT_146>Spacing())  lots = NormalizeDouble(Lots_146,2);
 if(RTT_147>Spacing())  lots = NormalizeDouble(Lots_147,2);
 if(RTT_148>Spacing())  lots = NormalizeDouble(Lots_148,2);
 if(RTT_149>Spacing())  lots = NormalizeDouble(Lots_149,2);
 if(RTT_150>Spacing())  lots = NormalizeDouble(Lots_150,2);
 if(RTT_151>Spacing())  lots = NormalizeDouble(Lots_151,2);
 if(RTT_152>Spacing())  lots = NormalizeDouble(Lots_152,2);
 if(RTT_153>Spacing())  lots = NormalizeDouble(Lots_153,2);
 if(RTT_154>Spacing())  lots = NormalizeDouble(Lots_154,2);
 if(RTT_155>Spacing())  lots = NormalizeDouble(Lots_155,2);
 if(RTT_156>Spacing())  lots = NormalizeDouble(Lots_156,2);
 if(RTT_157>Spacing())  lots = NormalizeDouble(Lots_157,2);
 if(RTT_158>Spacing())  lots = NormalizeDouble(Lots_158,2);
 if(RTT_159>Spacing())  lots = NormalizeDouble(Lots_159,2);
 if(RTT_160>Spacing())  lots = NormalizeDouble(Lots_160,2);
 if(RTT_161>Spacing())  lots = NormalizeDouble(Lots_161,2);
 if(RTT_162>Spacing())  lots = NormalizeDouble(Lots_162,2);
 if(RTT_163>Spacing())  lots = NormalizeDouble(Lots_163,2);
 if(RTT_164>Spacing())  lots = NormalizeDouble(Lots_164,2);
 if(RTT_165>Spacing())  lots = NormalizeDouble(Lots_165,2);
 if(RTT_166>Spacing())  lots = NormalizeDouble(Lots_166,2);
 if(RTT_167>Spacing())  lots = NormalizeDouble(Lots_167,2);
 if(RTT_168>Spacing())  lots = NormalizeDouble(Lots_168,2);
 if(RTT_169>Spacing())  lots = NormalizeDouble(Lots_169,2);
 if(RTT_170>Spacing())  lots = NormalizeDouble(Lots_170,2);
 if(RTT_171>Spacing())  lots = NormalizeDouble(Lots_171,2);
 if(RTT_172>Spacing())  lots = NormalizeDouble(Lots_172,2);
 if(RTT_173>Spacing())  lots = NormalizeDouble(Lots_173,2);
 if(RTT_174>Spacing())  lots = NormalizeDouble(Lots_174,2);
 if(RTT_175>Spacing())  lots = NormalizeDouble(Lots_175,2);
 if(RTT_176>Spacing())  lots = NormalizeDouble(Lots_176,2);
 if(RTT_177>Spacing())  lots = NormalizeDouble(Lots_177,2);
 if(RTT_178>Spacing())  lots = NormalizeDouble(Lots_178,2);
 if(RTT_179>Spacing())  lots = NormalizeDouble(Lots_179,2);
 if(RTT_180>Spacing())  lots = NormalizeDouble(Lots_180,2);
 if(RTT_181>Spacing())  lots = NormalizeDouble(Lots_181,2);
 if(RTT_182>Spacing())  lots = NormalizeDouble(Lots_182,2);
 if(RTT_183>Spacing())  lots = NormalizeDouble(Lots_183,2);
 if(RTT_184>Spacing())  lots = NormalizeDouble(Lots_184,2);
 if(RTT_185>Spacing())  lots = NormalizeDouble(Lots_185,2);
 if(RTT_186>Spacing())  lots = NormalizeDouble(Lots_186,2);
 if(RTT_187>Spacing())  lots = NormalizeDouble(Lots_187,2);
 if(RTT_188>Spacing())  lots = NormalizeDouble(Lots_188,2);
 if(RTT_189>Spacing())  lots = NormalizeDouble(Lots_189,2);
 if(RTT_190>Spacing())  lots = NormalizeDouble(Lots_190,2);
 if(RTT_191>Spacing())  lots = NormalizeDouble(Lots_191,2);
 if(RTT_192>Spacing())  lots = NormalizeDouble(Lots_192,2);
 if(RTT_193>Spacing())  lots = NormalizeDouble(Lots_193,2);
 if(RTT_194>Spacing())  lots = NormalizeDouble(Lots_194,2);
 if(RTT_195>Spacing())  lots = NormalizeDouble(Lots_195,2);
 if(RTT_196>Spacing())  lots = NormalizeDouble(Lots_196,2);
 if(RTT_197>Spacing())  lots = NormalizeDouble(Lots_197,2);
 if(RTT_198>Spacing())  lots = NormalizeDouble(Lots_198,2);
 if(RTT_199>Spacing())  lots = NormalizeDouble(Lots_199,2);
 if(RTT_200>Spacing())  lots = NormalizeDouble(Lots_200,2);
 if(RTT_201>Spacing())  lots = NormalizeDouble(Lots_201,2);
 
CurrentHighestLots=lots;
LastHighestLots=0;
 if(CurrentHighestLots>LastHighestLots && Post(tipe)>=0) 
 LastHighestLots=lots;
//----------------------------------------------------------------------------------//
     
 if(Post(tipe)==0 && RTT_00>Spacing())  lots = NormalizeDouble(Lots_00,2);
 if(Post(tipe)==1 && RTT_01>Spacing())  lots = NormalizeDouble(Lots_01,2);
 if(Post(tipe)==2 && RTT_02>Spacing())  lots = NormalizeDouble(Lots_02,2);
 if(Post(tipe)==3 && RTT_03>Spacing())  lots = NormalizeDouble(Lots_03,2);
 if(Post(tipe)==4 && RTT_04>Spacing())  lots = NormalizeDouble(Lots_04,2);
 if(Post(tipe)==5 && RTT_05>Spacing())  lots = NormalizeDouble(Lots_05,2);
 if(Post(tipe)==6 && RTT_06>Spacing())  lots = NormalizeDouble(Lots_06,2);
 if(Post(tipe)==7 && RTT_07>Spacing())  lots = NormalizeDouble(Lots_07,2);
 if(Post(tipe)==8 && RTT_08>Spacing())  lots = NormalizeDouble(Lots_08,2);
 if(Post(tipe)==9 && RTT_09>Spacing())  lots = NormalizeDouble(Lots_09,2);
 if(Post(tipe)==10 && RTT_10>Spacing())  lots = NormalizeDouble(Lots_10,2);
 if(Post(tipe)==11 && RTT_11>Spacing())  lots = NormalizeDouble(Lots_11,2);
 if(Post(tipe)==12 && RTT_12>Spacing())  lots = NormalizeDouble(Lots_12,2);
 if(Post(tipe)==13 && RTT_13>Spacing())  lots = NormalizeDouble(Lots_13,2);
 if(Post(tipe)==14 && RTT_14>Spacing())  lots = NormalizeDouble(Lots_14,2);
 if(Post(tipe)==15 && RTT_15>Spacing())  lots = NormalizeDouble(Lots_15,2);
 if(Post(tipe)==16 && RTT_16>Spacing())  lots = NormalizeDouble(Lots_16,2);
 if(Post(tipe)==17 && RTT_17>Spacing())  lots = NormalizeDouble(Lots_17,2);
 if(Post(tipe)==18 && RTT_18>Spacing())  lots = NormalizeDouble(Lots_18,2);
 if(Post(tipe)==19 && RTT_19>Spacing())  lots = NormalizeDouble(Lots_19,2);
 if(Post(tipe)==20 && RTT_20>Spacing())  lots = NormalizeDouble(Lots_20,2);
 if(Post(tipe)==21 && RTT_21>Spacing())  lots = NormalizeDouble(Lots_21,2);
 if(Post(tipe)==22 && RTT_22>Spacing())  lots = NormalizeDouble(Lots_22,2);
 if(Post(tipe)==23 && RTT_23>Spacing())  lots = NormalizeDouble(Lots_23,2);
 if(Post(tipe)==24 && RTT_24>Spacing())  lots = NormalizeDouble(Lots_24,2);
 if(Post(tipe)==25 && RTT_25>Spacing())  lots = NormalizeDouble(Lots_25,2);
 if(Post(tipe)==26 && RTT_26>Spacing())  lots = NormalizeDouble(Lots_26,2);
 if(Post(tipe)==27 && RTT_27>Spacing())  lots = NormalizeDouble(Lots_27,2);
 if(Post(tipe)==28 && RTT_28>Spacing())  lots = NormalizeDouble(Lots_28,2);
 if(Post(tipe)==29 && RTT_29>Spacing())  lots = NormalizeDouble(Lots_29,2);
 if(Post(tipe)==30 && RTT_30>Spacing())  lots = NormalizeDouble(Lots_30,2);
 if(Post(tipe)==31 && RTT_31>Spacing())  lots = NormalizeDouble(Lots_31,2);
 if(Post(tipe)==32 && RTT_32>Spacing())  lots = NormalizeDouble(Lots_32,2);
 if(Post(tipe)==33 && RTT_33>Spacing())  lots = NormalizeDouble(Lots_33,2);
 if(Post(tipe)==34 && RTT_34>Spacing())  lots = NormalizeDouble(Lots_34,2);
 if(Post(tipe)==35 && RTT_35>Spacing())  lots = NormalizeDouble(Lots_35,2);
 if(Post(tipe)==36 && RTT_36>Spacing())  lots = NormalizeDouble(Lots_36,2);
 if(Post(tipe)==37 && RTT_37>Spacing())  lots = NormalizeDouble(Lots_37,2);
 if(Post(tipe)==38 && RTT_38>Spacing())  lots = NormalizeDouble(Lots_38,2);
 if(Post(tipe)==39 && RTT_39>Spacing())  lots = NormalizeDouble(Lots_39,2);
 if(Post(tipe)==40 && RTT_40>Spacing())  lots = NormalizeDouble(Lots_40,2);
 if(Post(tipe)==41 && RTT_41>Spacing())  lots = NormalizeDouble(Lots_41,2);
 if(Post(tipe)==42 && RTT_42>Spacing())  lots = NormalizeDouble(Lots_42,2);
 if(Post(tipe)==43 && RTT_43>Spacing())  lots = NormalizeDouble(Lots_43,2);
 if(Post(tipe)==44 && RTT_44>Spacing())  lots = NormalizeDouble(Lots_44,2);
 if(Post(tipe)==45 && RTT_45>Spacing())  lots = NormalizeDouble(Lots_45,2);
 if(Post(tipe)==46 && RTT_46>Spacing())  lots = NormalizeDouble(Lots_46,2);
 if(Post(tipe)==47 && RTT_47>Spacing())  lots = NormalizeDouble(Lots_47,2);
 if(Post(tipe)==48 && RTT_48>Spacing())  lots = NormalizeDouble(Lots_48,2);
 if(Post(tipe)==49 && RTT_49>Spacing())  lots = NormalizeDouble(Lots_49,2);
 if(Post(tipe)==50 && RTT_50>Spacing())  lots = NormalizeDouble(Lots_50,2);
 if(Post(tipe)==51 && RTT_51>Spacing())  lots = NormalizeDouble(Lots_51,2);
 if(Post(tipe)==52 && RTT_52>Spacing())  lots = NormalizeDouble(Lots_52,2);
 if(Post(tipe)==53 && RTT_53>Spacing())  lots = NormalizeDouble(Lots_53,2);
 if(Post(tipe)==54 && RTT_54>Spacing())  lots = NormalizeDouble(Lots_54,2);
 if(Post(tipe)==55 && RTT_55>Spacing())  lots = NormalizeDouble(Lots_55,2);
 if(Post(tipe)==56 && RTT_56>Spacing())  lots = NormalizeDouble(Lots_56,2);
 if(Post(tipe)==57 && RTT_57>Spacing())  lots = NormalizeDouble(Lots_57,2);
 if(Post(tipe)==58 && RTT_58>Spacing())  lots = NormalizeDouble(Lots_58,2);
 if(Post(tipe)==59 && RTT_59>Spacing())  lots = NormalizeDouble(Lots_59,2);
 if(Post(tipe)==60 && RTT_60>Spacing())  lots = NormalizeDouble(Lots_60,2);
 if(Post(tipe)==61 && RTT_61>Spacing())  lots = NormalizeDouble(Lots_61,2);
 if(Post(tipe)==62 && RTT_62>Spacing())  lots = NormalizeDouble(Lots_62,2);
 if(Post(tipe)==63 && RTT_63>Spacing())  lots = NormalizeDouble(Lots_63,2);
 if(Post(tipe)==64 && RTT_64>Spacing())  lots = NormalizeDouble(Lots_64,2);
 if(Post(tipe)==65 && RTT_65>Spacing())  lots = NormalizeDouble(Lots_65,2);
 if(Post(tipe)==66 && RTT_66>Spacing())  lots = NormalizeDouble(Lots_66,2);
 if(Post(tipe)==67 && RTT_67>Spacing())  lots = NormalizeDouble(Lots_67,2);
 if(Post(tipe)==68 && RTT_68>Spacing())  lots = NormalizeDouble(Lots_68,2);
 if(Post(tipe)==69 && RTT_69>Spacing())  lots = NormalizeDouble(Lots_69,2);
 if(Post(tipe)==70 && RTT_70>Spacing())  lots = NormalizeDouble(Lots_70,2);
 if(Post(tipe)==71 && RTT_71>Spacing())  lots = NormalizeDouble(Lots_71,2);
 if(Post(tipe)==72 && RTT_72>Spacing())  lots = NormalizeDouble(Lots_72,2);
 if(Post(tipe)==73 && RTT_73>Spacing())  lots = NormalizeDouble(Lots_73,2);
 if(Post(tipe)==74 && RTT_74>Spacing())  lots = NormalizeDouble(Lots_74,2);
 if(Post(tipe)==75 && RTT_75>Spacing())  lots = NormalizeDouble(Lots_75,2);
 if(Post(tipe)==76 && RTT_76>Spacing())  lots = NormalizeDouble(Lots_76,2);
 if(Post(tipe)==77 && RTT_77>Spacing())  lots = NormalizeDouble(Lots_77,2);
 if(Post(tipe)==78 && RTT_78>Spacing())  lots = NormalizeDouble(Lots_78,2);
 if(Post(tipe)==79 && RTT_79>Spacing())  lots = NormalizeDouble(Lots_79,2);
 if(Post(tipe)==80 && RTT_80>Spacing())  lots = NormalizeDouble(Lots_80,2);
 if(Post(tipe)==81 && RTT_81>Spacing())  lots = NormalizeDouble(Lots_81,2);
 if(Post(tipe)==82 && RTT_82>Spacing())  lots = NormalizeDouble(Lots_82,2);
 if(Post(tipe)==83 && RTT_83>Spacing())  lots = NormalizeDouble(Lots_83,2);
 if(Post(tipe)==84 && RTT_84>Spacing())  lots = NormalizeDouble(Lots_84,2);
 if(Post(tipe)==85 && RTT_85>Spacing())  lots = NormalizeDouble(Lots_85,2);
 if(Post(tipe)==86 && RTT_86>Spacing())  lots = NormalizeDouble(Lots_86,2);
 if(Post(tipe)==87 && RTT_87>Spacing())  lots = NormalizeDouble(Lots_87,2);
 if(Post(tipe)==88 && RTT_88>Spacing())  lots = NormalizeDouble(Lots_88,2);
 if(Post(tipe)==89 && RTT_89>Spacing())  lots = NormalizeDouble(Lots_89,2);
 if(Post(tipe)==90 && RTT_90>Spacing())  lots = NormalizeDouble(Lots_90,2);
 if(Post(tipe)==91 && RTT_91>Spacing())  lots = NormalizeDouble(Lots_91,2);
 if(Post(tipe)==92 && RTT_92>Spacing())  lots = NormalizeDouble(Lots_92,2);
 if(Post(tipe)==93 && RTT_93>Spacing())  lots = NormalizeDouble(Lots_93,2);
 if(Post(tipe)==94 && RTT_94>Spacing())  lots = NormalizeDouble(Lots_94,2);
 if(Post(tipe)==95 && RTT_95>Spacing())  lots = NormalizeDouble(Lots_95,2);
 if(Post(tipe)==96 && RTT_96>Spacing())  lots = NormalizeDouble(Lots_96,2);
 if(Post(tipe)==97 && RTT_97>Spacing())  lots = NormalizeDouble(Lots_97,2);
 if(Post(tipe)==98 && RTT_98>Spacing())  lots = NormalizeDouble(Lots_98,2);
 if(Post(tipe)==99 && RTT_99>Spacing())  lots = NormalizeDouble(Lots_99,2);
 if(Post(tipe)==100 && RTT_100>Spacing())  lots = NormalizeDouble(Lots_100,2);
 if(Post(tipe)==101 && RTT_101>Spacing())  lots = NormalizeDouble(Lots_101,2);
 if(Post(tipe)==102 && RTT_102>Spacing())  lots = NormalizeDouble(Lots_102,2);
 if(Post(tipe)==103 && RTT_103>Spacing())  lots = NormalizeDouble(Lots_103,2);
 if(Post(tipe)==104 && RTT_104>Spacing())  lots = NormalizeDouble(Lots_104,2);
 if(Post(tipe)==105 && RTT_105>Spacing())  lots = NormalizeDouble(Lots_105,2);
 if(Post(tipe)==106 && RTT_106>Spacing())  lots = NormalizeDouble(Lots_106,2);
 if(Post(tipe)==107 && RTT_107>Spacing())  lots = NormalizeDouble(Lots_107,2);
 if(Post(tipe)==108 && RTT_108>Spacing())  lots = NormalizeDouble(Lots_108,2);
 if(Post(tipe)==109 && RTT_109>Spacing())  lots = NormalizeDouble(Lots_109,2);
 if(Post(tipe)==110 && RTT_110>Spacing())  lots = NormalizeDouble(Lots_110,2);
 if(Post(tipe)==111 && RTT_111>Spacing())  lots = NormalizeDouble(Lots_111,2);
 if(Post(tipe)==112 && RTT_112>Spacing())  lots = NormalizeDouble(Lots_112,2);
 if(Post(tipe)==113 && RTT_113>Spacing())  lots = NormalizeDouble(Lots_113,2);
 if(Post(tipe)==114 && RTT_114>Spacing())  lots = NormalizeDouble(Lots_114,2);
 if(Post(tipe)==115 && RTT_115>Spacing())  lots = NormalizeDouble(Lots_115,2);
 if(Post(tipe)==116 && RTT_116>Spacing())  lots = NormalizeDouble(Lots_116,2);
 if(Post(tipe)==117 && RTT_117>Spacing())  lots = NormalizeDouble(Lots_117,2);
 if(Post(tipe)==118 && RTT_118>Spacing())  lots = NormalizeDouble(Lots_118,2);
 if(Post(tipe)==119 && RTT_119>Spacing())  lots = NormalizeDouble(Lots_119,2);
 if(Post(tipe)==120 && RTT_120>Spacing())  lots = NormalizeDouble(Lots_120,2);
 if(Post(tipe)==121 && RTT_121>Spacing())  lots = NormalizeDouble(Lots_121,2);
 if(Post(tipe)==122 && RTT_122>Spacing())  lots = NormalizeDouble(Lots_122,2);
 if(Post(tipe)==123 && RTT_123>Spacing())  lots = NormalizeDouble(Lots_123,2);
 if(Post(tipe)==124 && RTT_124>Spacing())  lots = NormalizeDouble(Lots_124,2);
 if(Post(tipe)==125 && RTT_125>Spacing())  lots = NormalizeDouble(Lots_125,2);
 if(Post(tipe)==126 && RTT_126>Spacing())  lots = NormalizeDouble(Lots_126,2);
 if(Post(tipe)==127 && RTT_127>Spacing())  lots = NormalizeDouble(Lots_127,2);
 if(Post(tipe)==128 && RTT_128>Spacing())  lots = NormalizeDouble(Lots_128,2);
 if(Post(tipe)==129 && RTT_129>Spacing())  lots = NormalizeDouble(Lots_129,2);
 if(Post(tipe)==130 && RTT_130>Spacing())  lots = NormalizeDouble(Lots_130,2);
 if(Post(tipe)==131 && RTT_131>Spacing())  lots = NormalizeDouble(Lots_131,2);
 if(Post(tipe)==132 && RTT_132>Spacing())  lots = NormalizeDouble(Lots_132,2);
 if(Post(tipe)==133 && RTT_133>Spacing())  lots = NormalizeDouble(Lots_133,2);
 if(Post(tipe)==134 && RTT_134>Spacing())  lots = NormalizeDouble(Lots_134,2);
 if(Post(tipe)==135 && RTT_135>Spacing())  lots = NormalizeDouble(Lots_135,2);
 if(Post(tipe)==136 && RTT_136>Spacing())  lots = NormalizeDouble(Lots_136,2);
 if(Post(tipe)==137 && RTT_137>Spacing())  lots = NormalizeDouble(Lots_137,2);
 if(Post(tipe)==138 && RTT_138>Spacing())  lots = NormalizeDouble(Lots_138,2);
 if(Post(tipe)==139 && RTT_139>Spacing())  lots = NormalizeDouble(Lots_139,2);
 if(Post(tipe)==140 && RTT_140>Spacing())  lots = NormalizeDouble(Lots_140,2);
 if(Post(tipe)==141 && RTT_141>Spacing())  lots = NormalizeDouble(Lots_141,2);
 if(Post(tipe)==142 && RTT_142>Spacing())  lots = NormalizeDouble(Lots_142,2);
 if(Post(tipe)==143 && RTT_143>Spacing())  lots = NormalizeDouble(Lots_143,2);
 if(Post(tipe)==144 && RTT_144>Spacing())  lots = NormalizeDouble(Lots_144,2);
 if(Post(tipe)==145 && RTT_145>Spacing())  lots = NormalizeDouble(Lots_145,2);
 if(Post(tipe)==146 && RTT_146>Spacing())  lots = NormalizeDouble(Lots_146,2);
 if(Post(tipe)==147 && RTT_147>Spacing())  lots = NormalizeDouble(Lots_147,2);
 if(Post(tipe)==148 && RTT_148>Spacing())  lots = NormalizeDouble(Lots_148,2);
 if(Post(tipe)==149 && RTT_149>Spacing())  lots = NormalizeDouble(Lots_149,2);
 if(Post(tipe)==150 && RTT_150>Spacing())  lots = NormalizeDouble(Lots_150,2);
 if(Post(tipe)==151 && RTT_151>Spacing())  lots = NormalizeDouble(Lots_151,2);
 if(Post(tipe)==152 && RTT_152>Spacing())  lots = NormalizeDouble(Lots_152,2);
 if(Post(tipe)==153 && RTT_153>Spacing())  lots = NormalizeDouble(Lots_153,2);
 if(Post(tipe)==154 && RTT_154>Spacing())  lots = NormalizeDouble(Lots_154,2);
 if(Post(tipe)==155 && RTT_155>Spacing())  lots = NormalizeDouble(Lots_155,2);
 if(Post(tipe)==156 && RTT_156>Spacing())  lots = NormalizeDouble(Lots_156,2);
 if(Post(tipe)==157 && RTT_157>Spacing())  lots = NormalizeDouble(Lots_157,2);
 if(Post(tipe)==158 && RTT_158>Spacing())  lots = NormalizeDouble(Lots_158,2);
 if(Post(tipe)==159 && RTT_159>Spacing())  lots = NormalizeDouble(Lots_159,2);
 if(Post(tipe)==160 && RTT_160>Spacing())  lots = NormalizeDouble(Lots_160,2);
 if(Post(tipe)==161 && RTT_161>Spacing())  lots = NormalizeDouble(Lots_161,2);
 if(Post(tipe)==162 && RTT_162>Spacing())  lots = NormalizeDouble(Lots_162,2);
 if(Post(tipe)==163 && RTT_163>Spacing())  lots = NormalizeDouble(Lots_163,2);
 if(Post(tipe)==164 && RTT_164>Spacing())  lots = NormalizeDouble(Lots_164,2);
 if(Post(tipe)==165 && RTT_165>Spacing())  lots = NormalizeDouble(Lots_165,2);
 if(Post(tipe)==166 && RTT_166>Spacing())  lots = NormalizeDouble(Lots_166,2);
 if(Post(tipe)==167 && RTT_167>Spacing())  lots = NormalizeDouble(Lots_167,2);
 if(Post(tipe)==168 && RTT_168>Spacing())  lots = NormalizeDouble(Lots_168,2);
 if(Post(tipe)==169 && RTT_169>Spacing())  lots = NormalizeDouble(Lots_169,2);
 if(Post(tipe)==170 && RTT_170>Spacing())  lots = NormalizeDouble(Lots_170,2);
 if(Post(tipe)==171 && RTT_171>Spacing())  lots = NormalizeDouble(Lots_171,2);
 if(Post(tipe)==172 && RTT_172>Spacing())  lots = NormalizeDouble(Lots_172,2);
 if(Post(tipe)==173 && RTT_173>Spacing())  lots = NormalizeDouble(Lots_173,2);
 if(Post(tipe)==174 && RTT_174>Spacing())  lots = NormalizeDouble(Lots_174,2);
 if(Post(tipe)==175 && RTT_175>Spacing())  lots = NormalizeDouble(Lots_175,2);
 if(Post(tipe)==176 && RTT_176>Spacing())  lots = NormalizeDouble(Lots_176,2);
 if(Post(tipe)==177 && RTT_177>Spacing())  lots = NormalizeDouble(Lots_177,2);
 if(Post(tipe)==178 && RTT_178>Spacing())  lots = NormalizeDouble(Lots_178,2);
 if(Post(tipe)==179 && RTT_179>Spacing())  lots = NormalizeDouble(Lots_179,2);
 if(Post(tipe)==180 && RTT_180>Spacing())  lots = NormalizeDouble(Lots_180,2);
 if(Post(tipe)==181 && RTT_181>Spacing())  lots = NormalizeDouble(Lots_181,2);
 if(Post(tipe)==182 && RTT_182>Spacing())  lots = NormalizeDouble(Lots_182,2);
 if(Post(tipe)==183 && RTT_183>Spacing())  lots = NormalizeDouble(Lots_183,2);
 if(Post(tipe)==184 && RTT_184>Spacing())  lots = NormalizeDouble(Lots_184,2);
 if(Post(tipe)==185 && RTT_185>Spacing())  lots = NormalizeDouble(Lots_185,2);
 if(Post(tipe)==186 && RTT_186>Spacing())  lots = NormalizeDouble(Lots_186,2);
 if(Post(tipe)==187 && RTT_187>Spacing())  lots = NormalizeDouble(Lots_187,2);
 if(Post(tipe)==188 && RTT_188>Spacing())  lots = NormalizeDouble(Lots_188,2);
 if(Post(tipe)==189 && RTT_189>Spacing())  lots = NormalizeDouble(Lots_189,2);
 if(Post(tipe)==190 && RTT_190>Spacing())  lots = NormalizeDouble(Lots_190,2);
 if(Post(tipe)==191 && RTT_191>Spacing())  lots = NormalizeDouble(Lots_191,2);
 if(Post(tipe)==192 && RTT_192>Spacing())  lots = NormalizeDouble(Lots_192,2);
 if(Post(tipe)==193 && RTT_193>Spacing())  lots = NormalizeDouble(Lots_193,2);
 if(Post(tipe)==194 && RTT_194>Spacing())  lots = NormalizeDouble(Lots_194,2);
 if(Post(tipe)==195 && RTT_195>Spacing())  lots = NormalizeDouble(Lots_195,2);
 if(Post(tipe)==196 && RTT_196>Spacing())  lots = NormalizeDouble(Lots_196,2);
 if(Post(tipe)==197 && RTT_197>Spacing())  lots = NormalizeDouble(Lots_197,2);
 if(Post(tipe)==198 && RTT_198>Spacing())  lots = NormalizeDouble(Lots_198,2);
 if(Post(tipe)==199 && RTT_199>Spacing())  lots = NormalizeDouble(Lots_199,2);
 if(Post(tipe)==200 && RTT_200>Spacing())  lots = NormalizeDouble(Lots_200,2);
 if(Post(tipe)==201 && RTT_201>Spacing())  lots = NormalizeDouble(Lots_201,2);
     
 if(Post(tipe)==0 && RTT_00<=Spacing())  lots = 0.00;
 if(Post(tipe)==1 && RTT_01<=Spacing())  lots = 0.00;
 if(Post(tipe)==2 && RTT_02<=Spacing())  lots = 0.00;
 if(Post(tipe)==3 && RTT_03<=Spacing())  lots = 0.00;
 if(Post(tipe)==4 && RTT_04<=Spacing())  lots = 0.00;
 if(Post(tipe)==5 && RTT_05<=Spacing())  lots = 0.00;
 if(Post(tipe)==6 && RTT_06<=Spacing())  lots = 0.00;
 if(Post(tipe)==7 && RTT_07<=Spacing())  lots = 0.00;
 if(Post(tipe)==8 && RTT_08<=Spacing())  lots = 0.00;
 if(Post(tipe)==9 && RTT_09<=Spacing())  lots = 0.00;
 if(Post(tipe)==10 && RTT_10<=Spacing())  lots = 0.00;
 if(Post(tipe)==11 && RTT_11<=Spacing())  lots = 0.00;
 if(Post(tipe)==12 && RTT_12<=Spacing())  lots = 0.00;
 if(Post(tipe)==13 && RTT_13<=Spacing())  lots = 0.00;
 if(Post(tipe)==14 && RTT_14<=Spacing())  lots = 0.00;
 if(Post(tipe)==15 && RTT_15<=Spacing())  lots = 0.00;
 if(Post(tipe)==16 && RTT_16<=Spacing())  lots = 0.00;
 if(Post(tipe)==17 && RTT_17<=Spacing())  lots = 0.00;
 if(Post(tipe)==18 && RTT_18<=Spacing())  lots = 0.00;
 if(Post(tipe)==19 && RTT_19<=Spacing())  lots = 0.00;
 if(Post(tipe)==20 && RTT_20<=Spacing())  lots = 0.00;
 if(Post(tipe)==21 && RTT_21<=Spacing())  lots = 0.00;
 if(Post(tipe)==22 && RTT_22<=Spacing())  lots = 0.00;
 if(Post(tipe)==23 && RTT_23<=Spacing())  lots = 0.00;
 if(Post(tipe)==24 && RTT_24<=Spacing())  lots = 0.00;
 if(Post(tipe)==25 && RTT_25<=Spacing())  lots = 0.00;
 if(Post(tipe)==26 && RTT_26<=Spacing())  lots = 0.00;
 if(Post(tipe)==27 && RTT_27<=Spacing())  lots = 0.00;
 if(Post(tipe)==28 && RTT_28<=Spacing())  lots = 0.00;
 if(Post(tipe)==29 && RTT_29<=Spacing())  lots = 0.00;
 if(Post(tipe)==30 && RTT_30<=Spacing())  lots = 0.00;
 if(Post(tipe)==31 && RTT_31<=Spacing())  lots = 0.00;
 if(Post(tipe)==32 && RTT_32<=Spacing())  lots = 0.00;
 if(Post(tipe)==33 && RTT_33<=Spacing())  lots = 0.00;
 if(Post(tipe)==34 && RTT_34<=Spacing())  lots = 0.00;
 if(Post(tipe)==35 && RTT_35<=Spacing())  lots = 0.00;
 if(Post(tipe)==36 && RTT_36<=Spacing())  lots = 0.00;
 if(Post(tipe)==37 && RTT_37<=Spacing())  lots = 0.00;
 if(Post(tipe)==38 && RTT_38<=Spacing())  lots = 0.00;
 if(Post(tipe)==39 && RTT_39<=Spacing())  lots = 0.00;
 if(Post(tipe)==40 && RTT_40<=Spacing())  lots = 0.00;
 if(Post(tipe)==41 && RTT_41<=Spacing())  lots = 0.00;
 if(Post(tipe)==42 && RTT_42<=Spacing())  lots = 0.00;
 if(Post(tipe)==43 && RTT_43<=Spacing())  lots = 0.00;
 if(Post(tipe)==44 && RTT_44<=Spacing())  lots = 0.00;
 if(Post(tipe)==45 && RTT_45<=Spacing())  lots = 0.00;
 if(Post(tipe)==46 && RTT_46<=Spacing())  lots = 0.00;
 if(Post(tipe)==47 && RTT_47<=Spacing())  lots = 0.00;
 if(Post(tipe)==48 && RTT_48<=Spacing())  lots = 0.00;
 if(Post(tipe)==49 && RTT_49<=Spacing())  lots = 0.00;
 if(Post(tipe)==50 && RTT_50<=Spacing())  lots = 0.00;
 if(Post(tipe)==51 && RTT_51<=Spacing())  lots = 0.00;
 if(Post(tipe)==52 && RTT_52<=Spacing())  lots = 0.00;
 if(Post(tipe)==53 && RTT_53<=Spacing())  lots = 0.00;
 if(Post(tipe)==54 && RTT_54<=Spacing())  lots = 0.00;
 if(Post(tipe)==55 && RTT_55<=Spacing())  lots = 0.00;
 if(Post(tipe)==56 && RTT_56<=Spacing())  lots = 0.00;
 if(Post(tipe)==57 && RTT_57<=Spacing())  lots = 0.00;
 if(Post(tipe)==58 && RTT_58<=Spacing())  lots = 0.00;
 if(Post(tipe)==59 && RTT_59<=Spacing())  lots = 0.00;
 if(Post(tipe)==60 && RTT_60<=Spacing())  lots = 0.00;
 if(Post(tipe)==61 && RTT_61<=Spacing())  lots = 0.00;
 if(Post(tipe)==62 && RTT_62<=Spacing())  lots = 0.00;
 if(Post(tipe)==63 && RTT_63<=Spacing())  lots = 0.00;
 if(Post(tipe)==64 && RTT_64<=Spacing())  lots = 0.00;
 if(Post(tipe)==65 && RTT_65<=Spacing())  lots = 0.00;
 if(Post(tipe)==66 && RTT_66<=Spacing())  lots = 0.00;
 if(Post(tipe)==67 && RTT_67<=Spacing())  lots = 0.00;
 if(Post(tipe)==68 && RTT_68<=Spacing())  lots = 0.00;
 if(Post(tipe)==69 && RTT_69<=Spacing())  lots = 0.00;
 if(Post(tipe)==70 && RTT_70<=Spacing())  lots = 0.00;
 if(Post(tipe)==71 && RTT_71<=Spacing())  lots = 0.00;
 if(Post(tipe)==72 && RTT_72<=Spacing())  lots = 0.00;
 if(Post(tipe)==73 && RTT_73<=Spacing())  lots = 0.00;
 if(Post(tipe)==74 && RTT_74<=Spacing())  lots = 0.00;
 if(Post(tipe)==75 && RTT_75<=Spacing())  lots = 0.00;
 if(Post(tipe)==76 && RTT_76<=Spacing())  lots = 0.00;
 if(Post(tipe)==77 && RTT_77<=Spacing())  lots = 0.00;
 if(Post(tipe)==78 && RTT_78<=Spacing())  lots = 0.00;
 if(Post(tipe)==79 && RTT_79<=Spacing())  lots = 0.00;
 if(Post(tipe)==80 && RTT_80<=Spacing())  lots = 0.00;
 if(Post(tipe)==81 && RTT_81<=Spacing())  lots = 0.00;
 if(Post(tipe)==82 && RTT_82<=Spacing())  lots = 0.00;
 if(Post(tipe)==83 && RTT_83<=Spacing())  lots = 0.00;
 if(Post(tipe)==84 && RTT_84<=Spacing())  lots = 0.00;
 if(Post(tipe)==85 && RTT_85<=Spacing())  lots = 0.00;
 if(Post(tipe)==86 && RTT_86<=Spacing())  lots = 0.00;
 if(Post(tipe)==87 && RTT_87<=Spacing())  lots = 0.00;
 if(Post(tipe)==88 && RTT_88<=Spacing())  lots = 0.00;
 if(Post(tipe)==89 && RTT_89<=Spacing())  lots = 0.00;
 if(Post(tipe)==90 && RTT_90<=Spacing())  lots = 0.00;
 if(Post(tipe)==91 && RTT_91<=Spacing())  lots = 0.00;
 if(Post(tipe)==92 && RTT_92<=Spacing())  lots = 0.00;
 if(Post(tipe)==93 && RTT_93<=Spacing())  lots = 0.00;
 if(Post(tipe)==94 && RTT_94<=Spacing())  lots = 0.00;
 if(Post(tipe)==95 && RTT_95<=Spacing())  lots = 0.00;
 if(Post(tipe)==96 && RTT_96<=Spacing())  lots = 0.00;
 if(Post(tipe)==97 && RTT_97<=Spacing())  lots = 0.00;
 if(Post(tipe)==98 && RTT_98<=Spacing())  lots = 0.00;
 if(Post(tipe)==99 && RTT_99<=Spacing())  lots = 0.00;
 if(Post(tipe)==100 && RTT_100<=Spacing())  lots = 0.00;
 if(Post(tipe)==101 && RTT_101<=Spacing())  lots = 0.00;
 if(Post(tipe)==102 && RTT_102<=Spacing())  lots = 0.00;
 if(Post(tipe)==103 && RTT_103<=Spacing())  lots = 0.00;
 if(Post(tipe)==104 && RTT_104<=Spacing())  lots = 0.00;
 if(Post(tipe)==105 && RTT_105<=Spacing())  lots = 0.00;
 if(Post(tipe)==106 && RTT_106<=Spacing())  lots = 0.00;
 if(Post(tipe)==107 && RTT_107<=Spacing())  lots = 0.00;
 if(Post(tipe)==108 && RTT_108<=Spacing())  lots = 0.00;
 if(Post(tipe)==109 && RTT_109<=Spacing())  lots = 0.00;
 if(Post(tipe)==110 && RTT_110<=Spacing())  lots = 0.00;
 if(Post(tipe)==111 && RTT_111<=Spacing())  lots = 0.00;
 if(Post(tipe)==112 && RTT_112<=Spacing())  lots = 0.00;
 if(Post(tipe)==113 && RTT_113<=Spacing())  lots = 0.00;
 if(Post(tipe)==114 && RTT_114<=Spacing())  lots = 0.00;
 if(Post(tipe)==115 && RTT_115<=Spacing())  lots = 0.00;
 if(Post(tipe)==116 && RTT_116<=Spacing())  lots = 0.00;
 if(Post(tipe)==117 && RTT_117<=Spacing())  lots = 0.00;
 if(Post(tipe)==118 && RTT_118<=Spacing())  lots = 0.00;
 if(Post(tipe)==119 && RTT_119<=Spacing())  lots = 0.00;
 if(Post(tipe)==120 && RTT_120<=Spacing())  lots = 0.00;
 if(Post(tipe)==121 && RTT_121<=Spacing())  lots = 0.00;
 if(Post(tipe)==122 && RTT_122<=Spacing())  lots = 0.00;
 if(Post(tipe)==123 && RTT_123<=Spacing())  lots = 0.00;
 if(Post(tipe)==124 && RTT_124<=Spacing())  lots = 0.00;
 if(Post(tipe)==125 && RTT_125<=Spacing())  lots = 0.00;
 if(Post(tipe)==126 && RTT_126<=Spacing())  lots = 0.00;
 if(Post(tipe)==127 && RTT_127<=Spacing())  lots = 0.00;
 if(Post(tipe)==128 && RTT_128<=Spacing())  lots = 0.00;
 if(Post(tipe)==129 && RTT_129<=Spacing())  lots = 0.00;
 if(Post(tipe)==130 && RTT_130<=Spacing())  lots = 0.00;
 if(Post(tipe)==131 && RTT_131<=Spacing())  lots = 0.00;
 if(Post(tipe)==132 && RTT_132<=Spacing())  lots = 0.00;
 if(Post(tipe)==133 && RTT_133<=Spacing())  lots = 0.00;
 if(Post(tipe)==134 && RTT_134<=Spacing())  lots = 0.00;
 if(Post(tipe)==135 && RTT_135<=Spacing())  lots = 0.00;
 if(Post(tipe)==136 && RTT_136<=Spacing())  lots = 0.00;
 if(Post(tipe)==137 && RTT_137<=Spacing())  lots = 0.00;
 if(Post(tipe)==138 && RTT_138<=Spacing())  lots = 0.00;
 if(Post(tipe)==139 && RTT_139<=Spacing())  lots = 0.00;
 if(Post(tipe)==140 && RTT_140<=Spacing())  lots = 0.00;
 if(Post(tipe)==141 && RTT_141<=Spacing())  lots = 0.00;
 if(Post(tipe)==142 && RTT_142<=Spacing())  lots = 0.00;
 if(Post(tipe)==143 && RTT_143<=Spacing())  lots = 0.00;
 if(Post(tipe)==144 && RTT_144<=Spacing())  lots = 0.00;
 if(Post(tipe)==145 && RTT_145<=Spacing())  lots = 0.00;
 if(Post(tipe)==146 && RTT_146<=Spacing())  lots = 0.00;
 if(Post(tipe)==147 && RTT_147<=Spacing())  lots = 0.00;
 if(Post(tipe)==148 && RTT_148<=Spacing())  lots = 0.00;
 if(Post(tipe)==149 && RTT_149<=Spacing())  lots = 0.00;
 if(Post(tipe)==150 && RTT_150<=Spacing())  lots = 0.00;
 if(Post(tipe)==151 && RTT_151<=Spacing())  lots = 0.00;
 if(Post(tipe)==152 && RTT_152<=Spacing())  lots = 0.00;
 if(Post(tipe)==153 && RTT_153<=Spacing())  lots = 0.00;
 if(Post(tipe)==154 && RTT_154<=Spacing())  lots = 0.00;
 if(Post(tipe)==155 && RTT_155<=Spacing())  lots = 0.00;
 if(Post(tipe)==156 && RTT_156<=Spacing())  lots = 0.00;
 if(Post(tipe)==157 && RTT_157<=Spacing())  lots = 0.00;
 if(Post(tipe)==158 && RTT_158<=Spacing())  lots = 0.00;
 if(Post(tipe)==159 && RTT_159<=Spacing())  lots = 0.00;
 if(Post(tipe)==160 && RTT_160<=Spacing())  lots = 0.00;
 if(Post(tipe)==161 && RTT_161<=Spacing())  lots = 0.00;
 if(Post(tipe)==162 && RTT_162<=Spacing())  lots = 0.00;
 if(Post(tipe)==163 && RTT_163<=Spacing())  lots = 0.00;
 if(Post(tipe)==164 && RTT_164<=Spacing())  lots = 0.00;
 if(Post(tipe)==165 && RTT_165<=Spacing())  lots = 0.00;
 if(Post(tipe)==166 && RTT_166<=Spacing())  lots = 0.00;
 if(Post(tipe)==167 && RTT_167<=Spacing())  lots = 0.00;
 if(Post(tipe)==168 && RTT_168<=Spacing())  lots = 0.00;
 if(Post(tipe)==169 && RTT_169<=Spacing())  lots = 0.00;
 if(Post(tipe)==170 && RTT_170<=Spacing())  lots = 0.00;
 if(Post(tipe)==171 && RTT_171<=Spacing())  lots = 0.00;
 if(Post(tipe)==172 && RTT_172<=Spacing())  lots = 0.00;
 if(Post(tipe)==173 && RTT_173<=Spacing())  lots = 0.00;
 if(Post(tipe)==174 && RTT_174<=Spacing())  lots = 0.00;
 if(Post(tipe)==175 && RTT_175<=Spacing())  lots = 0.00;
 if(Post(tipe)==176 && RTT_176<=Spacing())  lots = 0.00;
 if(Post(tipe)==177 && RTT_177<=Spacing())  lots = 0.00;
 if(Post(tipe)==178 && RTT_178<=Spacing())  lots = 0.00;
 if(Post(tipe)==179 && RTT_179<=Spacing())  lots = 0.00;
 if(Post(tipe)==180 && RTT_180<=Spacing())  lots = 0.00;
 if(Post(tipe)==181 && RTT_181<=Spacing())  lots = 0.00;
 if(Post(tipe)==182 && RTT_182<=Spacing())  lots = 0.00;
 if(Post(tipe)==183 && RTT_183<=Spacing())  lots = 0.00;
 if(Post(tipe)==184 && RTT_184<=Spacing())  lots = 0.00;
 if(Post(tipe)==185 && RTT_185<=Spacing())  lots = 0.00;
 if(Post(tipe)==186 && RTT_186<=Spacing())  lots = 0.00;
 if(Post(tipe)==187 && RTT_187<=Spacing())  lots = 0.00;
 if(Post(tipe)==188 && RTT_188<=Spacing())  lots = 0.00;
 if(Post(tipe)==189 && RTT_189<=Spacing())  lots = 0.00;
 if(Post(tipe)==190 && RTT_190<=Spacing())  lots = 0.00;
 if(Post(tipe)==191 && RTT_191<=Spacing())  lots = 0.00;
 if(Post(tipe)==192 && RTT_192<=Spacing())  lots = 0.00;
 if(Post(tipe)==193 && RTT_193<=Spacing())  lots = 0.00;
 if(Post(tipe)==194 && RTT_194<=Spacing())  lots = 0.00;
 if(Post(tipe)==195 && RTT_195<=Spacing())  lots = 0.00;
 if(Post(tipe)==196 && RTT_196<=Spacing())  lots = 0.00;
 if(Post(tipe)==197 && RTT_197<=Spacing())  lots = 0.00;
 if(Post(tipe)==198 && RTT_198<=Spacing())  lots = 0.00;
 if(Post(tipe)==199 && RTT_199<=Spacing())  lots = 0.00;
 if(Post(tipe)==200 && RTT_200<=Spacing())  lots = 0.00;
 if(Post(tipe)==201 && RTT_201<=Spacing())  lots = 0.00;

//----------------------------------------------------------------------------------//
//                      if (Ranges<0) Lots == 0.00 ;
//----------------------------------------------------------------------------------//
 if( RTT_00<=Spacing())  Lots_00 = 0.00;
 if( RTT_01<=Spacing())  Lots_01 = 0.00;
 if( RTT_02<=Spacing())  Lots_02 = 0.00;
 if( RTT_03<=Spacing())  Lots_03 = 0.00;
 if( RTT_04<=Spacing())  Lots_04 = 0.00;
 if( RTT_05<=Spacing())  Lots_05 = 0.00;
 if( RTT_06<=Spacing())  Lots_06 = 0.00;
 if( RTT_07<=Spacing())  Lots_07 = 0.00;
 if( RTT_08<=Spacing())  Lots_08 = 0.00;
 if( RTT_09<=Spacing())  Lots_09 = 0.00;
 if( RTT_10<=Spacing())  Lots_10 = 0.00;
 if( RTT_11<=Spacing())  Lots_11 = 0.00;
 if( RTT_12<=Spacing())  Lots_12 = 0.00;
 if( RTT_13<=Spacing())  Lots_13 = 0.00;
 if( RTT_14<=Spacing())  Lots_14 = 0.00;
 if( RTT_15<=Spacing())  Lots_15 = 0.00;
 if( RTT_16<=Spacing())  Lots_16 = 0.00;
 if( RTT_17<=Spacing())  Lots_17 = 0.00;
 if( RTT_18<=Spacing())  Lots_18 = 0.00;
 if( RTT_19<=Spacing())  Lots_19 = 0.00;
 if( RTT_20<=Spacing())  Lots_20 = 0.00;
 if( RTT_21<=Spacing())  Lots_21 = 0.00;
 if( RTT_22<=Spacing())  Lots_22 = 0.00;
 if( RTT_23<=Spacing())  Lots_23 = 0.00;
 if( RTT_24<=Spacing())  Lots_24 = 0.00;
 if(  RTT_25<=Spacing())  Lots_25 = 0.00;
 if(  RTT_26<=Spacing())  Lots_26 = 0.00;
 if(  RTT_27<=Spacing())  Lots_27 = 0.00;
 if(  RTT_28<=Spacing())  Lots_28 = 0.00;
 if(  RTT_29<=Spacing())  Lots_29 = 0.00;
 if(  RTT_30<=Spacing())  Lots_30 = 0.00;
 if(  RTT_31<=Spacing())  Lots_31 = 0.00;
 if(  RTT_32<=Spacing())  Lots_32 = 0.00;
 if(  RTT_33<=Spacing())  Lots_33 = 0.00;
 if(  RTT_34<=Spacing())  Lots_34 = 0.00;
 if(  RTT_35<=Spacing())  Lots_35 = 0.00;
 if(  RTT_36<=Spacing())  Lots_36 = 0.00;
 if(  RTT_37<=Spacing())  Lots_37 = 0.00;
 if(  RTT_38<=Spacing())  Lots_38 = 0.00;
 if(  RTT_39<=Spacing())  Lots_39 = 0.00;
 if(  RTT_40<=Spacing())  Lots_40 = 0.00;
 if(  RTT_41<=Spacing())  Lots_41 = 0.00;
 if(  RTT_42<=Spacing())  Lots_42 = 0.00;
 if(  RTT_43<=Spacing())  Lots_43 = 0.00;
 if(  RTT_44<=Spacing())  Lots_44 = 0.00;
 if(  RTT_45<=Spacing())  Lots_45 = 0.00;
 if(  RTT_46<=Spacing())  Lots_46 = 0.00;
 if(  RTT_47<=Spacing())  Lots_47 = 0.00;
 if(  RTT_48<=Spacing())  Lots_48 = 0.00;
 if(  RTT_49<=Spacing())  Lots_49 = 0.00;
 if(  RTT_50<=Spacing())  Lots_50 = 0.00;
 if(  RTT_51<=Spacing())  Lots_51 = 0.00;
 if(  RTT_52<=Spacing())  Lots_52 = 0.00;
 if(  RTT_53<=Spacing())  Lots_53 = 0.00;
 if(  RTT_54<=Spacing())  Lots_54 = 0.00;
 if(  RTT_55<=Spacing())  Lots_55 = 0.00;
 if(  RTT_56<=Spacing())  Lots_56 = 0.00;
 if(  RTT_57<=Spacing())  Lots_57 = 0.00;
 if(  RTT_58<=Spacing())  Lots_58 = 0.00;
 if(  RTT_59<=Spacing())  Lots_59 = 0.00;
 if(  RTT_60<=Spacing())  Lots_60 = 0.00;
 if(  RTT_61<=Spacing())  Lots_61 = 0.00;
 if(  RTT_62<=Spacing())  Lots_62 = 0.00;
 if(  RTT_63<=Spacing())  Lots_63 = 0.00;
 if(  RTT_64<=Spacing())  Lots_64 = 0.00;
 if(  RTT_65<=Spacing())  Lots_65 = 0.00;
 if(  RTT_66<=Spacing())  Lots_66 = 0.00;
 if(  RTT_67<=Spacing())  Lots_67 = 0.00;
 if(  RTT_68<=Spacing())  Lots_68 = 0.00;
 if(  RTT_69<=Spacing())  Lots_69 = 0.00;
 if(  RTT_70<=Spacing())  Lots_70 = 0.00;
 if(  RTT_71<=Spacing())  Lots_71 = 0.00;
 if(  RTT_72<=Spacing())  Lots_72 = 0.00;
 if(  RTT_73<=Spacing())  Lots_73 = 0.00;
 if(  RTT_74<=Spacing())  Lots_74 = 0.00;
 if(  RTT_75<=Spacing())  Lots_75 = 0.00;
 if(  RTT_76<=Spacing())  Lots_76 = 0.00;
 if(  RTT_77<=Spacing())  Lots_77 = 0.00;
 if(  RTT_78<=Spacing())  Lots_78 = 0.00;
 if(  RTT_79<=Spacing())  Lots_79 = 0.00;
 if(  RTT_80<=Spacing())  Lots_80 = 0.00;
 if(  RTT_81<=Spacing())  Lots_81 = 0.00;
 if(  RTT_82<=Spacing())  Lots_82 = 0.00;
 if(  RTT_83<=Spacing())  Lots_83 = 0.00;
 if(  RTT_84<=Spacing())  Lots_84 = 0.00;
 if(  RTT_85<=Spacing())  Lots_85 = 0.00;
 if(  RTT_86<=Spacing())  Lots_86 = 0.00;
 if(  RTT_87<=Spacing())  Lots_87 = 0.00;
 if(  RTT_88<=Spacing())  Lots_88 = 0.00;
 if(  RTT_89<=Spacing())  Lots_89 = 0.00;
 if(  RTT_90<=Spacing())  Lots_90 = 0.00;
 if(  RTT_91<=Spacing())  Lots_91 = 0.00;
 if(  RTT_92<=Spacing())  Lots_92 = 0.00;
 if(  RTT_93<=Spacing())  Lots_93 = 0.00;
 if(  RTT_94<=Spacing())  Lots_94 = 0.00;
 if(  RTT_95<=Spacing())  Lots_95 = 0.00;
 if(  RTT_96<=Spacing())  Lots_96 = 0.00;
 if(  RTT_97<=Spacing())  Lots_97 = 0.00;
 if(  RTT_98<=Spacing())  Lots_98 = 0.00;
 if(  RTT_99<=Spacing())  Lots_99 = 0.00;
 if(  RTT_100<=Spacing())  Lots_100 = 0.00;
 if(  RTT_101<=Spacing())  Lots_101 = 0.00;
 if(  RTT_102<=Spacing())  Lots_102 = 0.00;
 if(  RTT_103<=Spacing())  Lots_103 = 0.00;
 if(  RTT_104<=Spacing())  Lots_104 = 0.00;
 if(  RTT_105<=Spacing())  Lots_105 = 0.00;
 if(  RTT_106<=Spacing())  Lots_106 = 0.00;
 if(  RTT_107<=Spacing())  Lots_107 = 0.00;
 if(  RTT_108<=Spacing())  Lots_108 = 0.00;
 if(  RTT_109<=Spacing())  Lots_109 = 0.00;
 if(  RTT_110<=Spacing())  Lots_110 = 0.00;
 if(  RTT_111<=Spacing())  Lots_111 = 0.00;
 if(  RTT_112<=Spacing())  Lots_112 = 0.00;
 if(  RTT_113<=Spacing())  Lots_113 = 0.00;
 if(  RTT_114<=Spacing())  Lots_114 = 0.00;
 if(  RTT_115<=Spacing())  Lots_115 = 0.00;
 if(  RTT_116<=Spacing())  Lots_116 = 0.00;
 if(  RTT_117<=Spacing())  Lots_117 = 0.00;
 if(  RTT_118<=Spacing())  Lots_118 = 0.00;
 if(  RTT_119<=Spacing())  Lots_119 = 0.00;
 if(  RTT_120<=Spacing())  Lots_120 = 0.00;
 if(  RTT_121<=Spacing())  Lots_121 = 0.00;
 if(  RTT_122<=Spacing())  Lots_122 = 0.00;
 if(  RTT_123<=Spacing())  Lots_123 = 0.00;
 if(  RTT_124<=Spacing())  Lots_124 = 0.00;
 if(  RTT_125<=Spacing())  Lots_125 = 0.00;
 if(  RTT_126<=Spacing())  Lots_126 = 0.00;
 if(  RTT_127<=Spacing())  Lots_127 = 0.00;
 if(  RTT_128<=Spacing())  Lots_128 = 0.00;
 if(  RTT_129<=Spacing())  Lots_129 = 0.00;
 if(  RTT_130<=Spacing())  Lots_130 = 0.00;
 if(  RTT_131<=Spacing())  Lots_131 = 0.00;
 if(  RTT_132<=Spacing())  Lots_132 = 0.00;
 if(  RTT_133<=Spacing())  Lots_133 = 0.00;
 if(  RTT_134<=Spacing())  Lots_134 = 0.00;
 if(  RTT_135<=Spacing())  Lots_135 = 0.00;
 if(  RTT_136<=Spacing())  Lots_136 = 0.00;
 if(  RTT_137<=Spacing())  Lots_137 = 0.00;
 if(  RTT_138<=Spacing())  Lots_138 = 0.00;
 if(  RTT_139<=Spacing())  Lots_139 = 0.00;
 if(  RTT_140<=Spacing())  Lots_140 = 0.00;
 if(  RTT_141<=Spacing())  Lots_141 = 0.00;
 if(  RTT_142<=Spacing())  Lots_142 = 0.00;
 if(  RTT_143<=Spacing())  Lots_143 = 0.00;
 if(  RTT_144<=Spacing())  Lots_144 = 0.00;
 if(  RTT_145<=Spacing())  Lots_145 = 0.00;
 if(  RTT_146<=Spacing())  Lots_146 = 0.00;
 if(  RTT_147<=Spacing())  Lots_147 = 0.00;
 if(  RTT_148<=Spacing())  Lots_148 = 0.00;
 if(  RTT_149<=Spacing())  Lots_149 = 0.00;
 if(  RTT_150<=Spacing())  Lots_150 = 0.00;
 if(  RTT_151<=Spacing())  Lots_151 = 0.00;
 if(  RTT_152<=Spacing())  Lots_152 = 0.00;
 if(  RTT_153<=Spacing())  Lots_153 = 0.00;
 if(  RTT_154<=Spacing())  Lots_154 = 0.00;
 if(  RTT_155<=Spacing())  Lots_155 = 0.00;
 if(  RTT_156<=Spacing())  Lots_156 = 0.00;
 if(  RTT_157<=Spacing())  Lots_157 = 0.00;
 if(  RTT_158<=Spacing())  Lots_158 = 0.00;
 if(  RTT_159<=Spacing())  Lots_159 = 0.00;
 if(  RTT_160<=Spacing())  Lots_160 = 0.00;
 if(  RTT_161<=Spacing())  Lots_161 = 0.00;
 if(  RTT_162<=Spacing())  Lots_162 = 0.00;
 if(  RTT_163<=Spacing())  Lots_163 = 0.00;
 if(  RTT_164<=Spacing())  Lots_164 = 0.00;
 if(  RTT_165<=Spacing())  Lots_165 = 0.00;
 if(  RTT_166<=Spacing())  Lots_166 = 0.00;
 if(  RTT_167<=Spacing())  Lots_167 = 0.00;
 if(  RTT_168<=Spacing())  Lots_168 = 0.00;
 if(  RTT_169<=Spacing())  Lots_169 = 0.00;
 if(  RTT_170<=Spacing())  Lots_170 = 0.00;
 if(  RTT_171<=Spacing())  Lots_171 = 0.00;
 if(  RTT_172<=Spacing())  Lots_172 = 0.00;
 if(  RTT_173<=Spacing())  Lots_173 = 0.00;
 if(  RTT_174<=Spacing())  Lots_174 = 0.00;
 if(  RTT_175<=Spacing())  Lots_175 = 0.00;
 if(  RTT_176<=Spacing())  Lots_176 = 0.00;
 if(  RTT_177<=Spacing())  Lots_177 = 0.00;
 if(  RTT_178<=Spacing())  Lots_178 = 0.00;
 if(  RTT_179<=Spacing())  Lots_179 = 0.00;
 if(  RTT_180<=Spacing())  Lots_180 = 0.00;
 if(  RTT_181<=Spacing())  Lots_181 = 0.00;
 if(  RTT_182<=Spacing())  Lots_182 = 0.00;
 if(  RTT_183<=Spacing())  Lots_183 = 0.00;
 if(  RTT_184<=Spacing())  Lots_184 = 0.00;
 if(  RTT_185<=Spacing())  Lots_185 = 0.00;
 if(  RTT_186<=Spacing())  Lots_186 = 0.00;
 if(  RTT_187<=Spacing())  Lots_187 = 0.00;
 if(  RTT_188<=Spacing())  Lots_188 = 0.00;
 if(  RTT_189<=Spacing())  Lots_189 = 0.00;
 if(  RTT_190<=Spacing())  Lots_190 = 0.00;
 if(  RTT_191<=Spacing())  Lots_191 = 0.00;
 if(  RTT_192<=Spacing())  Lots_192 = 0.00;
 if(  RTT_193<=Spacing())  Lots_193 = 0.00;
 if(  RTT_194<=Spacing())  Lots_194 = 0.00;
 if(  RTT_195<=Spacing())  Lots_195 = 0.00;
 if(  RTT_196<=Spacing())  Lots_196 = 0.00;
 if(  RTT_197<=Spacing())  Lots_197 = 0.00;
 if(  RTT_198<=Spacing())  Lots_198 = 0.00;
 if(  RTT_199<=Spacing())  Lots_199 = 0.00;
 if(  RTT_200<=Spacing())  Lots_200 = 0.00;
 if(  RTT_201<=Spacing())  Lots_201 = 0.00;

 BalUse_00 = NormalizeDouble(Lots_00,2)*RTT_00*val_cur;
 BalUse_01 = NormalizeDouble(Lots_01,2)*RTT_01*val_cur;
 BalUse_02 = NormalizeDouble(Lots_02,2)*RTT_02*val_cur;
 BalUse_03 = NormalizeDouble(Lots_03,2)*RTT_03*val_cur;
 BalUse_04 = NormalizeDouble(Lots_04,2)*RTT_04*val_cur;
 BalUse_05 = NormalizeDouble(Lots_05,2)*RTT_05*val_cur;
 BalUse_06 = NormalizeDouble(Lots_06,2)*RTT_06*val_cur;
 BalUse_07 = NormalizeDouble(Lots_07,2)*RTT_07*val_cur;
 BalUse_08 = NormalizeDouble(Lots_08,2)*RTT_08*val_cur;
 BalUse_09 = NormalizeDouble(Lots_09,2)*RTT_09*val_cur;
 BalUse_10 = NormalizeDouble(Lots_10,2)*RTT_10*val_cur;
 BalUse_11 = NormalizeDouble(Lots_11,2)*RTT_11*val_cur;
 BalUse_12 = NormalizeDouble(Lots_12,2)*RTT_12*val_cur;
 BalUse_13 = NormalizeDouble(Lots_13,2)*RTT_13*val_cur;
 BalUse_14 = NormalizeDouble(Lots_14,2)*RTT_14*val_cur;
 BalUse_15 = NormalizeDouble(Lots_15,2)*RTT_15*val_cur;
 BalUse_16 = NormalizeDouble(Lots_16,2)*RTT_16*val_cur;
 BalUse_17 = NormalizeDouble(Lots_17,2)*RTT_17*val_cur;
 BalUse_18 = NormalizeDouble(Lots_18,2)*RTT_18*val_cur;
 BalUse_19 = NormalizeDouble(Lots_19,2)*RTT_19*val_cur;
 BalUse_20 = NormalizeDouble(Lots_20,2)*RTT_20*val_cur;
 BalUse_21 = NormalizeDouble(Lots_21,2)*RTT_21*val_cur;
 BalUse_22 = NormalizeDouble(Lots_22,2)*RTT_22*val_cur;
 BalUse_23 = NormalizeDouble(Lots_23,2)*RTT_23*val_cur;
 BalUse_24 = NormalizeDouble(Lots_24,2)*RTT_24*val_cur;
 BalUse_25 = NormalizeDouble(Lots_25,2)*RTT_25*val_cur;
 BalUse_26 = NormalizeDouble(Lots_26,2)*RTT_26*val_cur;
 BalUse_27 = NormalizeDouble(Lots_27,2)*RTT_27*val_cur;
 BalUse_28 = NormalizeDouble(Lots_28,2)*RTT_28*val_cur;
 BalUse_29 = NormalizeDouble(Lots_29,2)*RTT_29*val_cur;
 BalUse_30 = NormalizeDouble(Lots_30,2)*RTT_30*val_cur;
 BalUse_31 = NormalizeDouble(Lots_31,2)*RTT_31*val_cur;
 BalUse_32 = NormalizeDouble(Lots_32,2)*RTT_32*val_cur;
 BalUse_33 = NormalizeDouble(Lots_33,2)*RTT_33*val_cur;
 BalUse_34 = NormalizeDouble(Lots_34,2)*RTT_34*val_cur;
 BalUse_35 = NormalizeDouble(Lots_35,2)*RTT_35*val_cur;
 BalUse_36 = NormalizeDouble(Lots_36,2)*RTT_36*val_cur;
 BalUse_37 = NormalizeDouble(Lots_37,2)*RTT_37*val_cur;
 BalUse_38 = NormalizeDouble(Lots_38,2)*RTT_38*val_cur;
 BalUse_39 = NormalizeDouble(Lots_39,2)*RTT_39*val_cur;
 BalUse_40 = NormalizeDouble(Lots_40,2)*RTT_40*val_cur;
 BalUse_41 = NormalizeDouble(Lots_41,2)*RTT_41*val_cur;
 BalUse_42 = NormalizeDouble(Lots_42,2)*RTT_42*val_cur;
 BalUse_43 = NormalizeDouble(Lots_43,2)*RTT_43*val_cur;
 BalUse_44 = NormalizeDouble(Lots_44,2)*RTT_44*val_cur;
 BalUse_45 = NormalizeDouble(Lots_45,2)*RTT_45*val_cur;
 BalUse_46 = NormalizeDouble(Lots_46,2)*RTT_46*val_cur;
 BalUse_47 = NormalizeDouble(Lots_47,2)*RTT_47*val_cur;
 BalUse_48 = NormalizeDouble(Lots_48,2)*RTT_48*val_cur;
 BalUse_49 = NormalizeDouble(Lots_49,2)*RTT_49*val_cur;
 BalUse_50 = NormalizeDouble(Lots_50,2)*RTT_50*val_cur;
 BalUse_51 = NormalizeDouble(Lots_51,2)*RTT_51*val_cur;
 BalUse_52 = NormalizeDouble(Lots_52,2)*RTT_52*val_cur;
 BalUse_53 = NormalizeDouble(Lots_53,2)*RTT_53*val_cur;
 BalUse_54 = NormalizeDouble(Lots_54,2)*RTT_54*val_cur;
 BalUse_55 = NormalizeDouble(Lots_55,2)*RTT_55*val_cur;
 BalUse_56 = NormalizeDouble(Lots_56,2)*RTT_56*val_cur;
 BalUse_57 = NormalizeDouble(Lots_57,2)*RTT_57*val_cur;
 BalUse_58 = NormalizeDouble(Lots_58,2)*RTT_58*val_cur;
 BalUse_59 = NormalizeDouble(Lots_59,2)*RTT_59*val_cur;
 BalUse_60 = NormalizeDouble(Lots_60,2)*RTT_60*val_cur;
 BalUse_61 = NormalizeDouble(Lots_61,2)*RTT_61*val_cur;
 BalUse_62 = NormalizeDouble(Lots_62,2)*RTT_62*val_cur;
 BalUse_63 = NormalizeDouble(Lots_63,2)*RTT_63*val_cur;
 BalUse_64 = NormalizeDouble(Lots_64,2)*RTT_64*val_cur;
 BalUse_65 = NormalizeDouble(Lots_65,2)*RTT_65*val_cur;
 BalUse_66 = NormalizeDouble(Lots_66,2)*RTT_66*val_cur;
 BalUse_67 = NormalizeDouble(Lots_67,2)*RTT_67*val_cur;
 BalUse_68 = NormalizeDouble(Lots_68,2)*RTT_68*val_cur;
 BalUse_69 = NormalizeDouble(Lots_69,2)*RTT_69*val_cur;
 BalUse_70 = NormalizeDouble(Lots_70,2)*RTT_70*val_cur;
 BalUse_71 = NormalizeDouble(Lots_71,2)*RTT_71*val_cur;
 BalUse_72 = NormalizeDouble(Lots_72,2)*RTT_72*val_cur;
 BalUse_73 = NormalizeDouble(Lots_73,2)*RTT_73*val_cur;
 BalUse_74 = NormalizeDouble(Lots_74,2)*RTT_74*val_cur;
 BalUse_75 = NormalizeDouble(Lots_75,2)*RTT_75*val_cur;
 BalUse_76 = NormalizeDouble(Lots_76,2)*RTT_76*val_cur;
 BalUse_77 = NormalizeDouble(Lots_77,2)*RTT_77*val_cur;
 BalUse_78 = NormalizeDouble(Lots_78,2)*RTT_78*val_cur;
 BalUse_79 = NormalizeDouble(Lots_79,2)*RTT_79*val_cur;
 BalUse_80 = NormalizeDouble(Lots_80,2)*RTT_80*val_cur;
 BalUse_81 = NormalizeDouble(Lots_81,2)*RTT_81*val_cur;
 BalUse_82 = NormalizeDouble(Lots_82,2)*RTT_82*val_cur;
 BalUse_83 = NormalizeDouble(Lots_83,2)*RTT_83*val_cur;
 BalUse_84 = NormalizeDouble(Lots_84,2)*RTT_84*val_cur;
 BalUse_85 = NormalizeDouble(Lots_85,2)*RTT_85*val_cur;
 BalUse_86 = NormalizeDouble(Lots_86,2)*RTT_86*val_cur;
 BalUse_87 = NormalizeDouble(Lots_87,2)*RTT_87*val_cur;
 BalUse_88 = NormalizeDouble(Lots_88,2)*RTT_88*val_cur;
 BalUse_89 = NormalizeDouble(Lots_89,2)*RTT_89*val_cur;
 BalUse_90 = NormalizeDouble(Lots_90,2)*RTT_90*val_cur;
 BalUse_91 = NormalizeDouble(Lots_91,2)*RTT_91*val_cur;
 BalUse_92 = NormalizeDouble(Lots_92,2)*RTT_92*val_cur;
 BalUse_93 = NormalizeDouble(Lots_93,2)*RTT_93*val_cur;
 BalUse_94 = NormalizeDouble(Lots_94,2)*RTT_94*val_cur;
 BalUse_95 = NormalizeDouble(Lots_95,2)*RTT_95*val_cur;
 BalUse_96 = NormalizeDouble(Lots_96,2)*RTT_96*val_cur;
 BalUse_97 = NormalizeDouble(Lots_97,2)*RTT_97*val_cur;
 BalUse_98 = NormalizeDouble(Lots_98,2)*RTT_98*val_cur;
 BalUse_99 = NormalizeDouble(Lots_99,2)*RTT_99*val_cur;
 BalUse_100 = NormalizeDouble(Lots_100,2)*RTT_100*val_cur;
 BalUse_101 = NormalizeDouble(Lots_101,2)*RTT_101*val_cur;
 BalUse_102 = NormalizeDouble(Lots_102,2)*RTT_102*val_cur;
 BalUse_103 = NormalizeDouble(Lots_103,2)*RTT_103*val_cur;
 BalUse_104 = NormalizeDouble(Lots_104,2)*RTT_104*val_cur;
 BalUse_105 = NormalizeDouble(Lots_105,2)*RTT_105*val_cur;
 BalUse_106 = NormalizeDouble(Lots_106,2)*RTT_106*val_cur;
 BalUse_107 = NormalizeDouble(Lots_107,2)*RTT_107*val_cur;
 BalUse_108 = NormalizeDouble(Lots_108,2)*RTT_108*val_cur;
 BalUse_109 = NormalizeDouble(Lots_109,2)*RTT_109*val_cur;
 BalUse_110 = NormalizeDouble(Lots_110,2)*RTT_110*val_cur;
 BalUse_111 = NormalizeDouble(Lots_111,2)*RTT_111*val_cur;
 BalUse_112 = NormalizeDouble(Lots_112,2)*RTT_112*val_cur;
 BalUse_113 = NormalizeDouble(Lots_113,2)*RTT_113*val_cur;
 BalUse_114 = NormalizeDouble(Lots_114,2)*RTT_114*val_cur;
 BalUse_115 = NormalizeDouble(Lots_115,2)*RTT_115*val_cur;
 BalUse_116 = NormalizeDouble(Lots_116,2)*RTT_116*val_cur;
 BalUse_117 = NormalizeDouble(Lots_117,2)*RTT_117*val_cur;
 BalUse_118 = NormalizeDouble(Lots_118,2)*RTT_118*val_cur;
 BalUse_119 = NormalizeDouble(Lots_119,2)*RTT_119*val_cur;
 BalUse_120 = NormalizeDouble(Lots_120,2)*RTT_120*val_cur;
 BalUse_121 = NormalizeDouble(Lots_121,2)*RTT_121*val_cur;
 BalUse_122 = NormalizeDouble(Lots_122,2)*RTT_122*val_cur;
 BalUse_123 = NormalizeDouble(Lots_123,2)*RTT_123*val_cur;
 BalUse_124 = NormalizeDouble(Lots_124,2)*RTT_124*val_cur;
 BalUse_125 = NormalizeDouble(Lots_125,2)*RTT_125*val_cur;
 BalUse_126 = NormalizeDouble(Lots_126,2)*RTT_126*val_cur;
 BalUse_127 = NormalizeDouble(Lots_127,2)*RTT_127*val_cur;
 BalUse_128 = NormalizeDouble(Lots_128,2)*RTT_128*val_cur;
 BalUse_129 = NormalizeDouble(Lots_129,2)*RTT_129*val_cur;
 BalUse_130 = NormalizeDouble(Lots_130,2)*RTT_130*val_cur;
 BalUse_131 = NormalizeDouble(Lots_131,2)*RTT_131*val_cur;
 BalUse_132 = NormalizeDouble(Lots_132,2)*RTT_132*val_cur;
 BalUse_133 = NormalizeDouble(Lots_133,2)*RTT_133*val_cur;
 BalUse_134 = NormalizeDouble(Lots_134,2)*RTT_134*val_cur;
 BalUse_135 = NormalizeDouble(Lots_135,2)*RTT_135*val_cur;
 BalUse_136 = NormalizeDouble(Lots_136,2)*RTT_136*val_cur;
 BalUse_137 = NormalizeDouble(Lots_137,2)*RTT_137*val_cur;
 BalUse_138 = NormalizeDouble(Lots_138,2)*RTT_138*val_cur;
 BalUse_139 = NormalizeDouble(Lots_139,2)*RTT_139*val_cur;
 BalUse_140 = NormalizeDouble(Lots_140,2)*RTT_140*val_cur;
 BalUse_141 = NormalizeDouble(Lots_141,2)*RTT_141*val_cur;
 BalUse_142 = NormalizeDouble(Lots_142,2)*RTT_142*val_cur;
 BalUse_143 = NormalizeDouble(Lots_143,2)*RTT_143*val_cur;
 BalUse_144 = NormalizeDouble(Lots_144,2)*RTT_144*val_cur;
 BalUse_145 = NormalizeDouble(Lots_145,2)*RTT_145*val_cur;
 BalUse_146 = NormalizeDouble(Lots_146,2)*RTT_146*val_cur;
 BalUse_147 = NormalizeDouble(Lots_147,2)*RTT_147*val_cur;
 BalUse_148 = NormalizeDouble(Lots_148,2)*RTT_148*val_cur;
 BalUse_149 = NormalizeDouble(Lots_149,2)*RTT_149*val_cur;
 BalUse_150 = NormalizeDouble(Lots_150,2)*RTT_150*val_cur;
 BalUse_151 = NormalizeDouble(Lots_151,2)*RTT_151*val_cur;
 BalUse_152 = NormalizeDouble(Lots_152,2)*RTT_152*val_cur;
 BalUse_153 = NormalizeDouble(Lots_153,2)*RTT_153*val_cur;
 BalUse_154 = NormalizeDouble(Lots_154,2)*RTT_154*val_cur;
 BalUse_155 = NormalizeDouble(Lots_155,2)*RTT_155*val_cur;
 BalUse_156 = NormalizeDouble(Lots_156,2)*RTT_156*val_cur;
 BalUse_157 = NormalizeDouble(Lots_157,2)*RTT_157*val_cur;
 BalUse_158 = NormalizeDouble(Lots_158,2)*RTT_158*val_cur;
 BalUse_159 = NormalizeDouble(Lots_159,2)*RTT_159*val_cur;
 BalUse_160 = NormalizeDouble(Lots_160,2)*RTT_160*val_cur;
 BalUse_161 = NormalizeDouble(Lots_161,2)*RTT_161*val_cur;
 BalUse_162 = NormalizeDouble(Lots_162,2)*RTT_162*val_cur;
 BalUse_163 = NormalizeDouble(Lots_163,2)*RTT_163*val_cur;
 BalUse_164 = NormalizeDouble(Lots_164,2)*RTT_164*val_cur;
 BalUse_165 = NormalizeDouble(Lots_165,2)*RTT_165*val_cur;
 BalUse_166 = NormalizeDouble(Lots_166,2)*RTT_166*val_cur;
 BalUse_167 = NormalizeDouble(Lots_167,2)*RTT_167*val_cur;
 BalUse_168 = NormalizeDouble(Lots_168,2)*RTT_168*val_cur;
 BalUse_169 = NormalizeDouble(Lots_169,2)*RTT_169*val_cur;
 BalUse_170 = NormalizeDouble(Lots_170,2)*RTT_170*val_cur;
 BalUse_171 = NormalizeDouble(Lots_171,2)*RTT_171*val_cur;
 BalUse_172 = NormalizeDouble(Lots_172,2)*RTT_172*val_cur;
 BalUse_173 = NormalizeDouble(Lots_173,2)*RTT_173*val_cur;
 BalUse_174 = NormalizeDouble(Lots_174,2)*RTT_174*val_cur;
 BalUse_175 = NormalizeDouble(Lots_175,2)*RTT_175*val_cur;
 BalUse_176 = NormalizeDouble(Lots_176,2)*RTT_176*val_cur;
 BalUse_177 = NormalizeDouble(Lots_177,2)*RTT_177*val_cur;
 BalUse_178 = NormalizeDouble(Lots_178,2)*RTT_178*val_cur;
 BalUse_179 = NormalizeDouble(Lots_179,2)*RTT_179*val_cur;
 BalUse_180 = NormalizeDouble(Lots_180,2)*RTT_180*val_cur;
 BalUse_181 = NormalizeDouble(Lots_181,2)*RTT_181*val_cur;
 BalUse_182 = NormalizeDouble(Lots_182,2)*RTT_182*val_cur;
 BalUse_183 = NormalizeDouble(Lots_183,2)*RTT_183*val_cur;
 BalUse_184 = NormalizeDouble(Lots_184,2)*RTT_184*val_cur;
 BalUse_185 = NormalizeDouble(Lots_185,2)*RTT_185*val_cur;
 BalUse_186 = NormalizeDouble(Lots_186,2)*RTT_186*val_cur;
 BalUse_187 = NormalizeDouble(Lots_187,2)*RTT_187*val_cur;
 BalUse_188 = NormalizeDouble(Lots_188,2)*RTT_188*val_cur;
 BalUse_189 = NormalizeDouble(Lots_189,2)*RTT_189*val_cur;
 BalUse_190 = NormalizeDouble(Lots_190,2)*RTT_190*val_cur;
 BalUse_191 = NormalizeDouble(Lots_191,2)*RTT_191*val_cur;
 BalUse_192 = NormalizeDouble(Lots_192,2)*RTT_192*val_cur;
 BalUse_193 = NormalizeDouble(Lots_193,2)*RTT_193*val_cur;
 BalUse_194 = NormalizeDouble(Lots_194,2)*RTT_194*val_cur;
 BalUse_195 = NormalizeDouble(Lots_195,2)*RTT_195*val_cur;
 BalUse_196 = NormalizeDouble(Lots_196,2)*RTT_196*val_cur;
 BalUse_197 = NormalizeDouble(Lots_197,2)*RTT_197*val_cur;
 BalUse_198 = NormalizeDouble(Lots_198,2)*RTT_198*val_cur;
 BalUse_199 = NormalizeDouble(Lots_199,2)*RTT_199*val_cur;
 BalUse_200 = NormalizeDouble(Lots_200,2)*RTT_200*val_cur;
 BalUse_201 = NormalizeDouble(Lots_201,2)*RTT_201*val_cur; 
 
 if(BalUse_00<=0) BalUse_00 = 0.00;
 if(BalUse_01<=0) BalUse_01 = 0.00;
 if(BalUse_02<=0) BalUse_02 = 0.00;
 if(BalUse_03<=0) BalUse_03 = 0.00;
 if(BalUse_04<=0) BalUse_04 = 0.00;
 if(BalUse_05<=0) BalUse_05 = 0.00;
 if(BalUse_06<=0) BalUse_06 = 0.00;
 if(BalUse_07<=0) BalUse_07 = 0.00;
 if(BalUse_08<=0) BalUse_08 = 0.00;
 if(BalUse_09<=0) BalUse_09 = 0.00;
 if(BalUse_10<=0) BalUse_10 = 0.00;
 if(BalUse_11<=0) BalUse_11 = 0.00;
 if(BalUse_12<=0) BalUse_12 = 0.00;
 if(BalUse_13<=0) BalUse_13 = 0.00;
 if(BalUse_14<=0) BalUse_14 = 0.00;
 if(BalUse_15<=0) BalUse_15 = 0.00;
 if(BalUse_16<=0) BalUse_16 = 0.00;
 if(BalUse_17<=0) BalUse_17 = 0.00;
 if(BalUse_18<=0) BalUse_18 = 0.00;
 if(BalUse_19<=0) BalUse_19 = 0.00;
 if(BalUse_20<=0) BalUse_20 = 0.00;
 if(BalUse_21<=0) BalUse_21 = 0.00;
 if(BalUse_22<=0) BalUse_22 = 0.00;
 if(BalUse_23<=0) BalUse_23 = 0.00;
 if(BalUse_24<=0) BalUse_24 = 0.00;
 if(BalUse_25<=0) BalUse_25 = 0.00;
 if(BalUse_26<=0) BalUse_26 = 0.00;
 if(BalUse_27<=0) BalUse_27 = 0.00;
 if(BalUse_28<=0) BalUse_28 = 0.00;
 if(BalUse_29<=0) BalUse_29 = 0.00;
 if(BalUse_30<=0) BalUse_30 = 0.00;
 if(BalUse_31<=0) BalUse_31 = 0.00;
 if(BalUse_32<=0) BalUse_32 = 0.00;
 if(BalUse_33<=0) BalUse_33 = 0.00;
 if(BalUse_34<=0) BalUse_34 = 0.00;
 if(BalUse_35<=0) BalUse_35 = 0.00;
 if(BalUse_36<=0) BalUse_36 = 0.00;
 if(BalUse_37<=0) BalUse_37 = 0.00;
 if(BalUse_38<=0) BalUse_38 = 0.00;
 if(BalUse_39<=0) BalUse_39 = 0.00;
 if(BalUse_40<=0) BalUse_40 = 0.00;
 if(BalUse_41<=0) BalUse_41 = 0.00;
 if(BalUse_42<=0) BalUse_42 = 0.00;
 if(BalUse_43<=0) BalUse_43 = 0.00;
 if(BalUse_44<=0) BalUse_44 = 0.00;
 if(BalUse_45<=0) BalUse_45 = 0.00;
 if(BalUse_46<=0) BalUse_46 = 0.00;
 if(BalUse_47<=0) BalUse_47 = 0.00;
 if(BalUse_48<=0) BalUse_48 = 0.00;
 if(BalUse_49<=0) BalUse_49 = 0.00;
 if(BalUse_50<=0) BalUse_50 = 0.00;
 if(BalUse_51<=0) BalUse_51 = 0.00;
 if(BalUse_52<=0) BalUse_52 = 0.00;
 if(BalUse_53<=0) BalUse_53 = 0.00;
 if(BalUse_54<=0) BalUse_54 = 0.00;
 if(BalUse_55<=0) BalUse_55 = 0.00;
 if(BalUse_56<=0) BalUse_56 = 0.00;
 if(BalUse_57<=0) BalUse_57 = 0.00;
 if(BalUse_58<=0) BalUse_58 = 0.00;
 if(BalUse_59<=0) BalUse_59 = 0.00;
 if(BalUse_60<=0) BalUse_60 = 0.00;
 if(BalUse_61<=0) BalUse_61 = 0.00;
 if(BalUse_62<=0) BalUse_62 = 0.00;
 if(BalUse_63<=0) BalUse_63 = 0.00;
 if(BalUse_64<=0) BalUse_64 = 0.00;
 if(BalUse_65<=0) BalUse_65 = 0.00;
 if(BalUse_66<=0) BalUse_66 = 0.00;
 if(BalUse_67<=0) BalUse_67 = 0.00;
 if(BalUse_68<=0) BalUse_68 = 0.00;
 if(BalUse_69<=0) BalUse_69 = 0.00;
 if(BalUse_70<=0) BalUse_70 = 0.00;
 if(BalUse_71<=0) BalUse_71 = 0.00;
 if(BalUse_72<=0) BalUse_72 = 0.00;
 if(BalUse_73<=0) BalUse_73 = 0.00;
 if(BalUse_74<=0) BalUse_74 = 0.00;
 if(BalUse_75<=0) BalUse_75 = 0.00;
 if(BalUse_76<=0) BalUse_76 = 0.00;
 if(BalUse_77<=0) BalUse_77 = 0.00;
 if(BalUse_78<=0) BalUse_78 = 0.00;
 if(BalUse_79<=0) BalUse_79 = 0.00;
 if(BalUse_80<=0) BalUse_80 = 0.00;
 if(BalUse_81<=0) BalUse_81 = 0.00;
 if(BalUse_82<=0) BalUse_82 = 0.00;
 if(BalUse_83<=0) BalUse_83 = 0.00;
 if(BalUse_84<=0) BalUse_84 = 0.00;
 if(BalUse_85<=0) BalUse_85 = 0.00;
 if(BalUse_86<=0) BalUse_86 = 0.00;
 if(BalUse_87<=0) BalUse_87 = 0.00;
 if(BalUse_88<=0) BalUse_88 = 0.00;
 if(BalUse_89<=0) BalUse_89 = 0.00;
 if(BalUse_90<=0) BalUse_90 = 0.00;
 if(BalUse_91<=0) BalUse_91 = 0.00;
 if(BalUse_92<=0) BalUse_92 = 0.00;
 if(BalUse_93<=0) BalUse_93 = 0.00;
 if(BalUse_94<=0) BalUse_94 = 0.00;
 if(BalUse_95<=0) BalUse_95 = 0.00;
 if(BalUse_96<=0) BalUse_96 = 0.00;
 if(BalUse_97<=0) BalUse_97 = 0.00;
 if(BalUse_98<=0) BalUse_98 = 0.00;
 if(BalUse_99<=0) BalUse_99 = 0.00;
 if(BalUse_100<=0) BalUse_100 = 0.00;
 if(BalUse_101<=0) BalUse_101 = 0.00;
 if(BalUse_102<=0) BalUse_102 = 0.00;
 if(BalUse_103<=0) BalUse_103 = 0.00;
 if(BalUse_104<=0) BalUse_104 = 0.00;
 if(BalUse_105<=0) BalUse_105 = 0.00;
 if(BalUse_106<=0) BalUse_106 = 0.00;
 if(BalUse_107<=0) BalUse_107 = 0.00;
 if(BalUse_108<=0) BalUse_108 = 0.00;
 if(BalUse_109<=0) BalUse_109 = 0.00;
 if(BalUse_110<=0) BalUse_110 = 0.00;
 if(BalUse_111<=0) BalUse_111 = 0.00;
 if(BalUse_112<=0) BalUse_112 = 0.00;
 if(BalUse_113<=0) BalUse_113 = 0.00;
 if(BalUse_114<=0) BalUse_114 = 0.00;
 if(BalUse_115<=0) BalUse_115 = 0.00;
 if(BalUse_116<=0) BalUse_116 = 0.00;
 if(BalUse_117<=0) BalUse_117 = 0.00;
 if(BalUse_118<=0) BalUse_118 = 0.00;
 if(BalUse_119<=0) BalUse_119 = 0.00;
 if(BalUse_120<=0) BalUse_120 = 0.00;
 if(BalUse_121<=0) BalUse_121 = 0.00;
 if(BalUse_122<=0) BalUse_122 = 0.00;
 if(BalUse_123<=0) BalUse_123 = 0.00;
 if(BalUse_124<=0) BalUse_124 = 0.00;
 if(BalUse_125<=0) BalUse_125 = 0.00;
 if(BalUse_126<=0) BalUse_126 = 0.00;
 if(BalUse_127<=0) BalUse_127 = 0.00;
 if(BalUse_128<=0) BalUse_128 = 0.00;
 if(BalUse_129<=0) BalUse_129 = 0.00;
 if(BalUse_130<=0) BalUse_130 = 0.00;
 if(BalUse_131<=0) BalUse_131 = 0.00;
 if(BalUse_132<=0) BalUse_132 = 0.00;
 if(BalUse_133<=0) BalUse_133 = 0.00;
 if(BalUse_134<=0) BalUse_134 = 0.00;
 if(BalUse_135<=0) BalUse_135 = 0.00;
 if(BalUse_136<=0) BalUse_136 = 0.00;
 if(BalUse_137<=0) BalUse_137 = 0.00;
 if(BalUse_138<=0) BalUse_138 = 0.00;
 if(BalUse_139<=0) BalUse_139 = 0.00;
 if(BalUse_140<=0) BalUse_140 = 0.00;
 if(BalUse_141<=0) BalUse_141 = 0.00;
 if(BalUse_142<=0) BalUse_142 = 0.00;
 if(BalUse_143<=0) BalUse_143 = 0.00;
 if(BalUse_144<=0) BalUse_144 = 0.00;
 if(BalUse_145<=0) BalUse_145 = 0.00;
 if(BalUse_146<=0) BalUse_146 = 0.00;
 if(BalUse_147<=0) BalUse_147 = 0.00;
 if(BalUse_148<=0) BalUse_148 = 0.00;
 if(BalUse_149<=0) BalUse_149 = 0.00;
 if(BalUse_150<=0) BalUse_150 = 0.00;
 if(BalUse_151<=0) BalUse_151 = 0.00;
 if(BalUse_152<=0) BalUse_152 = 0.00;
 if(BalUse_153<=0) BalUse_153 = 0.00;
 if(BalUse_154<=0) BalUse_154 = 0.00;
 if(BalUse_155<=0) BalUse_155 = 0.00;
 if(BalUse_156<=0) BalUse_156 = 0.00;
 if(BalUse_157<=0) BalUse_157 = 0.00;
 if(BalUse_158<=0) BalUse_158 = 0.00;
 if(BalUse_159<=0) BalUse_159 = 0.00;
 if(BalUse_160<=0) BalUse_160 = 0.00;
 if(BalUse_161<=0) BalUse_161 = 0.00;
 if(BalUse_162<=0) BalUse_162 = 0.00;
 if(BalUse_163<=0) BalUse_163 = 0.00;
 if(BalUse_164<=0) BalUse_164 = 0.00;
 if(BalUse_165<=0) BalUse_165 = 0.00;
 if(BalUse_166<=0) BalUse_166 = 0.00;
 if(BalUse_167<=0) BalUse_167 = 0.00;
 if(BalUse_168<=0) BalUse_168 = 0.00;
 if(BalUse_169<=0) BalUse_169 = 0.00;
 if(BalUse_170<=0) BalUse_170 = 0.00;
 if(BalUse_171<=0) BalUse_171 = 0.00;
 if(BalUse_172<=0) BalUse_172 = 0.00;
 if(BalUse_173<=0) BalUse_173 = 0.00;
 if(BalUse_174<=0) BalUse_174 = 0.00;
 if(BalUse_175<=0) BalUse_175 = 0.00;
 if(BalUse_176<=0) BalUse_176 = 0.00;
 if(BalUse_177<=0) BalUse_177 = 0.00;
 if(BalUse_178<=0) BalUse_178 = 0.00;
 if(BalUse_179<=0) BalUse_179 = 0.00;
 if(BalUse_180<=0) BalUse_180 = 0.00;
 if(BalUse_181<=0) BalUse_181 = 0.00;
 if(BalUse_182<=0) BalUse_182 = 0.00;
 if(BalUse_183<=0) BalUse_183 = 0.00;
 if(BalUse_184<=0) BalUse_184 = 0.00;
 if(BalUse_185<=0) BalUse_185 = 0.00;
 if(BalUse_186<=0) BalUse_186 = 0.00;
 if(BalUse_187<=0) BalUse_187 = 0.00;
 if(BalUse_188<=0) BalUse_188 = 0.00;
 if(BalUse_189<=0) BalUse_189 = 0.00;
 if(BalUse_190<=0) BalUse_190 = 0.00;
 if(BalUse_191<=0) BalUse_191 = 0.00;
 if(BalUse_192<=0) BalUse_192 = 0.00;
 if(BalUse_193<=0) BalUse_193 = 0.00;
 if(BalUse_194<=0) BalUse_194 = 0.00;
 if(BalUse_195<=0) BalUse_195 = 0.00;
 if(BalUse_196<=0) BalUse_196 = 0.00;
 if(BalUse_197<=0) BalUse_197 = 0.00;
 if(BalUse_198<=0) BalUse_198 = 0.00;
 if(BalUse_199<=0) BalUse_199= 0.00;
 if(BalUse_200<=0) BalUse_200 = 0.00;
 if(BalUse_201<=0) BalUse_201 = 0.00;
 
 Sum_Balance = 
 BalUse_00
+BalUse_01
+BalUse_02
+BalUse_03
+BalUse_04
+BalUse_05
+BalUse_06
+BalUse_07
+BalUse_08
+BalUse_09
+BalUse_10
+BalUse_11
+BalUse_12
+BalUse_13
+BalUse_14
+BalUse_15
+BalUse_16
+BalUse_17
+BalUse_18
+BalUse_19
+BalUse_20
+BalUse_21
+BalUse_22
+BalUse_23
+BalUse_24
+BalUse_25
+BalUse_26
+BalUse_27
+BalUse_28
+BalUse_29
+BalUse_30
+BalUse_31
+BalUse_32
+BalUse_33
+BalUse_34
+BalUse_35
+BalUse_36
+BalUse_37
+BalUse_38
+BalUse_39
+BalUse_40
+BalUse_41
+BalUse_42
+BalUse_43
+BalUse_44
+BalUse_45
+BalUse_46
+BalUse_47
+BalUse_48
+BalUse_49
+BalUse_50
+BalUse_51
+BalUse_52
+BalUse_53
+BalUse_54
+BalUse_55
+BalUse_56
+BalUse_57
+BalUse_58
+BalUse_59
+BalUse_60
+BalUse_61
+BalUse_62
+BalUse_63
+BalUse_64
+BalUse_65
+BalUse_66
+BalUse_67
+BalUse_68
+BalUse_69
+BalUse_70
+BalUse_71
+BalUse_72
+BalUse_73
+BalUse_74
+BalUse_75
+BalUse_76
+BalUse_77
+BalUse_78
+BalUse_79
+BalUse_80
+BalUse_81
+BalUse_82
+BalUse_83
+BalUse_84
+BalUse_85
+BalUse_86
+BalUse_87
+BalUse_88
+BalUse_89
+BalUse_90
+BalUse_91
+BalUse_92
+BalUse_93
+BalUse_94
+BalUse_95
+BalUse_96
+BalUse_97
+BalUse_98
+BalUse_99
+BalUse_100
+BalUse_101
+BalUse_102
+BalUse_103
+BalUse_104
+BalUse_105
+BalUse_106
+BalUse_107
+BalUse_108
+BalUse_109
+BalUse_110
+BalUse_111
+BalUse_112
+BalUse_113
+BalUse_114
+BalUse_115
+BalUse_116
+BalUse_117
+BalUse_118
+BalUse_119
+BalUse_120
+BalUse_121
+BalUse_122
+BalUse_123
+BalUse_124
+BalUse_125
+BalUse_126
+BalUse_127
+BalUse_128
+BalUse_129
+BalUse_130
+BalUse_131
+BalUse_132
+BalUse_133
+BalUse_134
+BalUse_135
+BalUse_136
+BalUse_137
+BalUse_138
+BalUse_139
+BalUse_140
+BalUse_141
+BalUse_142
+BalUse_143
+BalUse_144
+BalUse_145
+BalUse_146
+BalUse_147
+BalUse_148
+BalUse_149
+BalUse_150
+BalUse_151
+BalUse_152
+BalUse_153
+BalUse_154
+BalUse_155
+BalUse_156
+BalUse_157
+BalUse_158
+BalUse_159
+BalUse_160
+BalUse_161
+BalUse_162
+BalUse_163
+BalUse_164
+BalUse_165
+BalUse_166
+BalUse_167
+BalUse_168
+BalUse_169
+BalUse_170
+BalUse_171
+BalUse_172
+BalUse_173
+BalUse_174
+BalUse_175
+BalUse_176
+BalUse_177
+BalUse_178
+BalUse_179
+BalUse_180
+BalUse_181
+BalUse_182
+BalUse_183
+BalUse_184
+BalUse_185
+BalUse_186
+BalUse_187
+BalUse_188
+BalUse_189
+BalUse_190
+BalUse_191
+BalUse_192
+BalUse_193
+BalUse_194
+BalUse_195
+BalUse_196
+BalUse_197
+BalUse_198
+BalUse_199
+BalUse_200
+BalUse_201
;

// Find The Correct Multiplier from The BalanceToTrade
My_Multiple_Lots=My_InitialMultiple_Lots;

if (BalanceToTrade*99/100>Sum_Balance  && My_Multiple_Lots>0 && !IsTradeContextBusy() )
Mpx+= 0.0003;
else if (BalanceToTrade*99/100<Sum_Balance && My_Multiple_Lots>0 && !IsTradeContextBusy()) 
Mpx-= 0.0003;
 
  My_Multiple_Lots= My_InitialMultiple_Lots+Mpx;
}}}
l=lots;

return(l);}


double TotalLots(int tipe) { 
   double val = 0;
   double lt=0;
   for (int i = 0; i < OrdersTotal(); i++) {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()== Symbol() && OrderMagicNumber()==Magic 
         && OrderType() == tipe){
         val += OrderLots();
         
}
}
      }
      lt=val;
   return (val);
}


//---------takeprofit setting

void Target () {

if(UseMyBalance==TRUE) Balance = NormalizeDouble(AccountBalance()*(MyBalance/100),2);
if(UseMyBalance==FALSE) Balance = NormalizeDouble(AccountBalance(),2);
 BalanceToTrade = NormalizeDouble((Balance * Allocation())/100,2);
  T_Harian = NormalizeDouble(balanc * (DailyTarget_ / 100),Digits);   
   balanc= BalanceToTrade;
   if(time_Bal != iTime(Symbol(),BreakTime ,0)) {
      time_Bal = iTime(Symbol(),BreakTime,0);
      play = 1;
      T_Harian = NormalizeDouble(balanc * (DailyTarget_ / 100),Digits);   
      if(!stop) ObjectDelete(alert);ObjectsDeleteAll();
      if(play) ObjectDelete(alert);
   }
return;
}




double DailyReturn(int tipe) {
 double dClose = 0;
 double dOpen = 0;
 double dTotal = 0;
 
 int idx;
 for (idx = 0; idx < OrdersHistoryTotal(); idx++) {
         if(OrderSelect(idx,SELECT_BY_POS,MODE_HISTORY)){
   if(OrderCloseTime() >= iTime(Symbol(),BreakTime,0) && OrderSymbol()==Symbol() && OrderMagicNumber()==Magic && OrderType() == tipe) {
      dClose += NormalizeDouble((OrderProfit()+OrderSwap()+OrderCommission()),2);
   }
 }
} 
 for (idx = 0; idx < OrdersTotal(); idx++) {
         if(OrderSelect(idx,SELECT_BY_POS,MODE_TRADES)){
   if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic && OrderType() == tipe) {
      dOpen += NormalizeDouble((OrderProfit()+OrderSwap()+OrderCommission()),2);
   }
 }
}
  if((Post(0)+Post(1))>0){ dTotal = (dOpen + dClose);} else if((Post(0)+Post(1))<=0){ dTotal =0;}
 return(dTotal);
}


double DailyReturns() {
 double dClose = 0;
 double dOpen = 0;
 double dTotal = 0;
 
 int idx;
 for (idx = 0; idx < OrdersHistoryTotal(); idx++) {
         if(OrderSelect(idx,SELECT_BY_POS,MODE_HISTORY)){
   if(OrderCloseTime() >= iTime(Symbol(),BreakTime,0) && OrderSymbol()==Symbol() && OrderMagicNumber()==Magic) {
      dClose +=  NormalizeDouble((OrderProfit()+OrderSwap()+OrderCommission()),2);
   }
 }
} 
 for (idx = 0; idx < OrdersTotal(); idx++) {
         if(OrderSelect(idx,SELECT_BY_POS,MODE_TRADES)){
   if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic) {
      dOpen  +=  NormalizeDouble((OrderProfit()+OrderSwap()+OrderCommission()),2);
   }
 }
}
 if((Post(0)+Post(1))>0 ){ dTotal = (dOpen + dClose);} else if((Post(0)+Post(1))<=0 ){ dTotal =0;}
 return(dTotal);
}

int CloseThisSymbolAll_Buy () {
int cp=0;
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      int os=OrderSelect(cc, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic && OrderType ()==OP_BUY  ) {
         if ( !IsTradeContextBusy() ) {
             cp=OrderClose(OrderTicket(), OrderLots(), Bid, slip, Blue);
            
         }Print("Close Buy : Reached Target "+ Symbol() + " Totals: "+ IntegerToString(cc) );
         Sleep(100);
      }if(Post(0)==0)break;
   }return(cp);
}
int CloseThisSymbolAll_Sell () {
int cp=0;
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      int os=OrderSelect(cc, SELECT_BY_POS, MODE_TRADES);
       if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic && OrderType ()==OP_SELL  ) {
         if ( !IsTradeContextBusy() ) {
           cp=OrderClose(OrderTicket(), OrderLots(), Ask, slip, Red);
         }Print("Close Sell : Reached Target "+ Symbol() + " Totals: "+ IntegerToString(cc) );
         Sleep(100);
      }if(Post(1)==0)break;
   }return(cp);
}

int CloseThisSymbolAll() {
int cp=0;
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      int os=OrderSelect(cc, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() && OrderMagicNumber()!=Magic)continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber()==Magic) {
         if (  !IsTradeContextBusy() ) {
         if (DailyReturn(0)>DailyReturn(1) ){
            if ( !IsTradeContextBusy()&& OrderType()==0) cp=OrderClose(OrderTicket(), OrderLots(), Bid, slip, Blue);
            if ( !IsTradeContextBusy()&& OrderType()==1) cp=OrderClose(OrderTicket(), OrderLots(), Ask, slip, Red);
            }
          if (DailyReturn(1)>DailyReturn(0) ){
            if ( !IsTradeContextBusy()&& OrderType()==1) cp=OrderClose(OrderTicket(), OrderLots(), Ask, slip, Red);
            if ( !IsTradeContextBusy()&& OrderType()==0) cp=OrderClose(OrderTicket(), OrderLots(), Bid, slip, Blue);
            }
            
         } Print("CloseAll : Reached Target " + Symbol() + " Totals: "+ IntegerToString(cc) );
         Sleep(100);
      }if(Post(0)+Post(1)==0)break;
   }return (cp);
}
void Alertz(string t, string isi) {
   alert = t;
   if(ObjectFind(t) <= -1) {
      ObjectCreate(t,OBJ_LABEL,0,0,0);
      ObjectSet(t,OBJPROP_XDISTANCE,20);
      ObjectSet(t,OBJPROP_YDISTANCE,20);
      ObjectSet(t,OBJPROP_CORNER,1);
      ObjectSet(t,OBJPROP_COLOR,clrGold);
      ObjectSetText(t,isi);
      ObjectSet(t,OBJPROP_FONTSIZE,20);
   }
return;
}    


int Spacing(){
int l;
l=(MaxRange() /(NumLines));
return (l);}


double MaxLots(){
double maxlot=0;
maxlot=
MarketInfo(Symbol(),MODE_MAXLOT);
return maxlot;
}

// Auto Adjust MaxRange . When the MaxRange need to Increase 
// because the HighestLots is bigger than MAXLOT.
// Auto Adjust MaxRange . When The MaxRange is bigger
// than HighestRange on Trade Planned.
int MaxRange (){
int r=0;
int increase=0;
r=initialMaxRange;

if(LastHighestLots<MaxLots()&& r<=HighestMaxRange)
increase=0;
else 
if(LastHighestLots> MaxLots()&& r<=HighestMaxRange)
increase+=1;
r=initialMaxRange+increase;
 
if(LastHighestLots<MaxLots() && r>HighestMaxRange)
increase-=1;
r=initialMaxRange+increase;

return r;
}

double Allocation (){
double alo=initialAllocation;
int increase =0;

if ((LastHighestLots>MaxLots() )&& ( MaxRange()>HighestMaxRange))
increase-=1;

alo = initialAllocation+increase;

return alo;
}

