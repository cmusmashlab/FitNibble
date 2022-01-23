<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="8.3.2">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="VCNL4040M3OE">
<packages>
<package name="VISHAY_VCNL4040_4X2X1.1">
<text x="-1.34143125" y="2.46848125" size="0.7633875" layer="25">&gt;NAME</text>
<text x="-1.64921875" y="-3.14586875" size="0.7648875" layer="27">&gt;VALUE</text>
<wire x1="-1.175" y1="2.17" x2="1.175" y2="2.17" width="0.127" layer="51"/>
<wire x1="1.175" y1="2.17" x2="1.175" y2="-2.17" width="0.127" layer="51"/>
<wire x1="1.175" y1="-2.17" x2="-1.175" y2="-2.17" width="0.127" layer="52"/>
<wire x1="-1.175" y1="-2.17" x2="-1.175" y2="2.17" width="0.127" layer="51"/>
<circle x="-1.907" y="2.05" radius="0.05" width="0.127" layer="21"/>
<wire x1="-1.5" y1="2.5" x2="1.5" y2="2.5" width="0.127" layer="39"/>
<wire x1="1.5" y1="2.5" x2="1.5" y2="-2.5" width="0.127" layer="39"/>
<wire x1="1.5" y1="-2.5" x2="-1.5" y2="-2.5" width="0.127" layer="39"/>
<wire x1="-1.5" y1="-2.5" x2="-1.5" y2="2.5" width="0.127" layer="39"/>
<smd name="4" x="-0.7" y="-1.6125" dx="0.7" dy="0.725" layer="1"/>
<smd name="1" x="-0.7" y="1.6125" dx="0.7" dy="0.725" layer="1"/>
<smd name="2" x="-0.7" y="0.5375" dx="0.7" dy="0.725" layer="1"/>
<smd name="3" x="-0.7" y="-0.5375" dx="0.7" dy="0.725" layer="1"/>
<smd name="5" x="0.7" y="-1.6125" dx="0.7" dy="0.725" layer="1"/>
<smd name="8" x="0.7" y="1.6125" dx="0.7" dy="0.725" layer="1"/>
<smd name="6" x="0.7" y="-0.5375" dx="0.7" dy="0.725" layer="1"/>
<smd name="7" x="0.7" y="0.5375" dx="0.7" dy="0.725" layer="1"/>
</package>
</packages>
<symbols>
<symbol name="VCNL4040M3OE">
<wire x1="-12.7" y1="12.7" x2="12.7" y2="12.7" width="0.4064" layer="94"/>
<wire x1="12.7" y1="12.7" x2="12.7" y2="-12.7" width="0.4064" layer="94"/>
<wire x1="12.7" y1="-12.7" x2="-12.7" y2="-12.7" width="0.4064" layer="94"/>
<wire x1="-12.7" y1="-12.7" x2="-12.7" y2="12.7" width="0.4064" layer="94"/>
<wire x1="-11.43" y1="11.43" x2="8.89" y2="11.43" width="0.254" layer="94"/>
<wire x1="8.89" y1="11.43" x2="11.43" y2="11.43" width="0.254" layer="94"/>
<wire x1="11.43" y1="11.43" x2="11.43" y2="-11.43" width="0.254" layer="94"/>
<wire x1="11.43" y1="-11.43" x2="-11.43" y2="-11.43" width="0.254" layer="94"/>
<wire x1="-11.43" y1="-11.43" x2="-11.43" y2="11.43" width="0.254" layer="94"/>
<text x="-17.8107" y="-1.272190625" size="1.272190625" layer="94">VDD</text>
<text x="13.9848" y="-6.356690625" size="1.271340625" layer="94">C-LED</text>
<text x="13.9823" y="-1.27111875" size="1.27111875" layer="94">INT</text>
<text x="13.9979" y="3.8176" size="1.272540625" layer="94">SDA</text>
<text x="14.0007" y="8.909509375" size="1.272790625" layer="94">SCL</text>
<text x="-17.8051" y="8.902590625" size="1.271790625" layer="94">GND</text>
<text x="-22.8977" y="3.81628125" size="1.272090625" layer="94">C-SENSOR</text>
<text x="-21.608" y="-6.355290625" size="1.271059375" layer="94">VDD-LED</text>
<text x="-5.08888125" y="13.9944" size="1.7811" layer="95">&gt;NAME</text>
<text x="-5.09186875" y="-15.2756" size="1.78215" layer="96">&gt;VALUE</text>
<wire x1="10.16" y1="-10.16" x2="6.35" y2="-10.16" width="0.254" layer="94"/>
<wire x1="6.35" y1="-10.16" x2="6.35" y2="-7.62" width="0.254" layer="94"/>
<wire x1="6.35" y1="-7.62" x2="6.35" y2="-1.27" width="0.254" layer="94"/>
<wire x1="6.35" y1="-1.27" x2="10.16" y2="-1.27" width="0.254" layer="94"/>
<wire x1="10.16" y1="-1.27" x2="10.16" y2="-10.16" width="0.254" layer="94"/>
<wire x1="3.81" y1="-8.89" x2="3.81" y2="-7.62" width="0.254" layer="94"/>
<wire x1="3.81" y1="-7.62" x2="3.81" y2="-3.81" width="0.254" layer="94"/>
<wire x1="3.81" y1="-3.81" x2="-3.81" y2="-3.81" width="0.254" layer="94"/>
<wire x1="-3.81" y1="-3.81" x2="-6.35" y2="-3.81" width="0.254" layer="94"/>
<wire x1="-6.35" y1="-3.81" x2="-6.35" y2="-5.08" width="0.254" layer="94"/>
<wire x1="-6.35" y1="-5.08" x2="-6.35" y2="-8.89" width="0.254" layer="94"/>
<wire x1="-6.35" y1="-8.89" x2="3.81" y2="-8.89" width="0.254" layer="94"/>
<wire x1="-7.62" y1="10.16" x2="-7.62" y2="7.62" width="0.254" layer="94"/>
<wire x1="-7.62" y1="7.62" x2="-7.62" y2="6.35" width="0.254" layer="94"/>
<wire x1="-7.62" y1="6.35" x2="-3.81" y2="6.35" width="0.254" layer="94"/>
<wire x1="-3.81" y1="6.35" x2="-2.54" y2="6.35" width="0.254" layer="94"/>
<wire x1="-2.54" y1="6.35" x2="-2.54" y2="7.62" width="0.254" layer="94"/>
<wire x1="-2.54" y1="7.62" x2="-2.54" y2="10.16" width="0.254" layer="94"/>
<wire x1="-2.54" y1="10.16" x2="-7.62" y2="10.16" width="0.254" layer="94"/>
<wire x1="-6.35" y1="3.81" x2="-6.35" y2="-1.27" width="0.254" layer="94"/>
<wire x1="-6.35" y1="-1.27" x2="-3.81" y2="-1.27" width="0.254" layer="94"/>
<wire x1="-3.81" y1="-1.27" x2="2.54" y2="-1.27" width="0.254" layer="94"/>
<wire x1="2.54" y1="-1.27" x2="2.54" y2="3.81" width="0.254" layer="94"/>
<wire x1="2.54" y1="3.81" x2="-3.81" y2="3.81" width="0.254" layer="94"/>
<wire x1="-3.81" y1="3.81" x2="-6.35" y2="3.81" width="0.254" layer="94"/>
<wire x1="-3.81" y1="6.35" x2="-3.81" y2="3.81" width="0.254" layer="94"/>
<wire x1="-3.81" y1="-1.27" x2="-3.81" y2="-3.81" width="0.254" layer="94"/>
<wire x1="3.81" y1="-7.62" x2="6.35" y2="-7.62" width="0.254" layer="94"/>
<wire x1="-1.27" y1="10.16" x2="-1.27" y2="7.62" width="0.254" layer="94"/>
<wire x1="-1.27" y1="7.62" x2="-1.27" y2="5.08" width="0.254" layer="94"/>
<wire x1="-1.27" y1="5.08" x2="6.35" y2="5.08" width="0.254" layer="94"/>
<wire x1="6.35" y1="5.08" x2="6.35" y2="6.35" width="0.254" layer="94"/>
<wire x1="6.35" y1="6.35" x2="6.35" y2="10.16" width="0.254" layer="94"/>
<wire x1="6.35" y1="10.16" x2="-1.27" y2="10.16" width="0.254" layer="94"/>
<wire x1="6.35" y1="6.35" x2="8.89" y2="6.35" width="0.254" layer="94"/>
<wire x1="8.89" y1="6.35" x2="8.89" y2="7.62" width="0.254" layer="94"/>
<wire x1="8.89" y1="7.62" x2="8.89" y2="11.43" width="0.254" layer="94"/>
<wire x1="-1.27" y1="7.62" x2="-2.54" y2="7.62" width="0.254" layer="94"/>
<wire x1="-7.62" y1="7.62" x2="-8.89" y2="7.62" width="0.254" layer="94"/>
<wire x1="-8.89" y1="7.62" x2="-8.89" y2="2.54" width="0.254" layer="94"/>
<wire x1="-8.89" y1="2.54" x2="-8.89" y2="1.778" width="0.254" layer="94"/>
<wire x1="-8.89" y1="1.778" x2="-10.16" y2="1.778" width="0.254" layer="94"/>
<wire x1="-8.89" y1="1.778" x2="-7.62" y2="1.778" width="0.254" layer="94"/>
<wire x1="-6.35" y1="-5.08" x2="-8.89" y2="-5.08" width="0.254" layer="94"/>
<wire x1="-8.89" y1="-5.08" x2="-8.89" y2="-8.89" width="0.254" layer="94"/>
<wire x1="-8.89" y1="-8.89" x2="-8.89" y2="-10.16" width="0.254" layer="94"/>
<wire x1="-8.89" y1="-10.16" x2="-7.62" y2="-10.16" width="0.254" layer="94"/>
<wire x1="-8.89" y1="-10.16" x2="-10.16" y2="-10.16" width="0.254" layer="94"/>
<text x="-6.87541875" y="7.639359375" size="1.27323125" layer="94">DSP</text>
<text x="1.01673125" y="8.133840625" size="1.270909375" layer="94">LED</text>
<text x="-0.764196875" y="5.85885" size="1.27366875" layer="94">DRIVER</text>
<text x="-3.81891875" y="0.763784375" size="1.27296875" layer="94">OSCI</text>
<text x="-4.32236875" y="-5.3394" size="1.27128125" layer="94">I2C BUS</text>
<text x="-5.59648125" y="-8.649109375" size="1.27193125" layer="94">CONTROLL</text>
<text x="-3.31156875" y="-6.877890625" size="1.27368125" layer="94">Logic</text>
<text x="6.880990625" y="-3.82276875" size="1.27425" layer="94">ALS</text>
<text x="7.1255" y="-6.10756875" size="1.272409375" layer="94">16</text>
<text x="6.8669" y="-8.901540625" size="1.271640625" layer="94">BIT</text>
<wire x1="-8.89" y1="2.54" x2="-10.16" y2="5.08" width="0.254" layer="94"/>
<wire x1="-10.16" y1="5.08" x2="-7.62" y2="5.08" width="0.254" layer="94"/>
<wire x1="-7.62" y1="5.08" x2="-8.89" y2="2.54" width="0.254" layer="94"/>
<wire x1="-10.16" y1="2.54" x2="-7.62" y2="2.54" width="0.254" layer="94"/>
<wire x1="-7.62" y1="-6.35" x2="-10.16" y2="-6.35" width="0.254" layer="94"/>
<wire x1="-10.16" y1="-6.35" x2="-8.89" y2="-8.89" width="0.254" layer="94"/>
<wire x1="-8.89" y1="-8.89" x2="-7.62" y2="-6.35" width="0.254" layer="94"/>
<wire x1="-7.62" y1="-8.89" x2="-10.16" y2="-8.89" width="0.254" layer="94"/>
<wire x1="10.16" y1="10.16" x2="7.62" y2="10.16" width="0.254" layer="94"/>
<wire x1="7.62" y1="10.16" x2="8.89" y2="7.62" width="0.254" layer="94"/>
<wire x1="8.89" y1="7.62" x2="10.16" y2="10.16" width="0.254" layer="94"/>
<wire x1="7.62" y1="7.62" x2="10.16" y2="7.62" width="0.254" layer="94"/>
<wire x1="9.398" y1="7.112" x2="10.16" y2="6.35" width="0.127" layer="94"/>
<wire x1="10.16" y1="6.35" x2="9.906" y2="6.858" width="0.127" layer="94"/>
<wire x1="9.906" y1="6.858" x2="9.652" y2="6.604" width="0.127" layer="94"/>
<wire x1="9.652" y1="6.604" x2="10.16" y2="6.35" width="0.127" layer="94"/>
<wire x1="10.16" y1="7.112" x2="10.922" y2="6.35" width="0.127" layer="94"/>
<wire x1="10.922" y1="6.35" x2="10.668" y2="6.858" width="0.127" layer="94"/>
<wire x1="10.668" y1="6.858" x2="10.414" y2="6.604" width="0.127" layer="94"/>
<wire x1="10.414" y1="6.604" x2="10.922" y2="6.35" width="0.127" layer="94"/>
<wire x1="-10.922" y1="6.35" x2="-10.16" y2="5.588" width="0.127" layer="94"/>
<wire x1="-10.16" y1="5.588" x2="-10.414" y2="6.096" width="0.127" layer="94"/>
<wire x1="-10.414" y1="6.096" x2="-10.668" y2="5.842" width="0.127" layer="94"/>
<wire x1="-10.668" y1="5.842" x2="-10.16" y2="5.588" width="0.127" layer="94"/>
<wire x1="-10.16" y1="6.35" x2="-9.398" y2="5.588" width="0.127" layer="94"/>
<wire x1="-9.398" y1="5.588" x2="-9.652" y2="6.096" width="0.127" layer="94"/>
<wire x1="-9.652" y1="6.096" x2="-9.906" y2="5.842" width="0.127" layer="94"/>
<wire x1="-9.906" y1="5.842" x2="-9.398" y2="5.588" width="0.127" layer="94"/>
<wire x1="-10.922" y1="-5.08" x2="-10.16" y2="-5.842" width="0.127" layer="94"/>
<wire x1="-10.16" y1="-5.842" x2="-10.414" y2="-5.334" width="0.127" layer="94"/>
<wire x1="-10.414" y1="-5.334" x2="-10.668" y2="-5.588" width="0.127" layer="94"/>
<wire x1="-10.668" y1="-5.588" x2="-10.16" y2="-5.842" width="0.127" layer="94"/>
<wire x1="-10.16" y1="-5.08" x2="-9.398" y2="-5.842" width="0.127" layer="94"/>
<wire x1="-9.398" y1="-5.842" x2="-9.652" y2="-5.334" width="0.127" layer="94"/>
<wire x1="-9.652" y1="-5.334" x2="-9.906" y2="-5.588" width="0.127" layer="94"/>
<wire x1="-9.906" y1="-5.588" x2="-9.398" y2="-5.842" width="0.127" layer="94"/>
<text x="-9.90933125" y="-2.286759375" size="1.27043125" layer="94">DS</text>
<text x="-9.9204" y="-0.25436875" size="1.271840625" layer="94">PS</text>
<text x="-6.880340625" y="-10.7027" size="1.27413125" layer="94">ALS</text>
<text x="-2.794990625" y="-10.6718" size="1.270459375" layer="94">PD</text>
<circle x="-10.668" y="10.668" radius="0.254" width="0.254" layer="94"/>
<circle x="-10.668" y="10.668" radius="0.179603125" width="0.254" layer="94"/>
<circle x="-10.541" y="10.668" radius="0.127" width="0.254" layer="94"/>
<pin name="C-SENSOR" x="-17.78" y="2.54" visible="pad" length="middle" direction="out"/>
<pin name="VDD" x="-17.78" y="-2.54" visible="pad" length="middle" direction="pwr"/>
<pin name="VDD-LED" x="-17.78" y="-7.62" visible="pad" length="middle" direction="pwr"/>
<pin name="SCL" x="17.78" y="7.62" visible="pad" length="middle" direction="in" function="clk" rot="R180"/>
<pin name="SDA" x="17.78" y="2.54" visible="pad" length="middle" rot="R180"/>
<pin name="INT" x="17.78" y="-2.54" visible="pad" length="middle" direction="out" rot="R180"/>
<pin name="C-LED" x="17.78" y="-7.62" visible="pad" length="middle" direction="out" rot="R180"/>
<pin name="GND" x="-17.78" y="7.62" visible="pad" length="middle" direction="pwr"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="VCNL4040M3OE" prefix="U">
<description>&lt;b&gt;VCNL4040&lt;/b&gt;

&lt;p&gt;Fully Integrated Proximity and Ambient Light Sensor with
Infrared Emitter, I2C Interface, and Interrupt Function:
&lt;ul&gt; 

VCNL4040 integrates a proximity sensor (PS), ambient
light sensor (ALS), and a high power IRED into one small
package. It incorporates photodiodes, amplifiers, and
analog to digital converting circuits into a single chip by
CMOS process. The 16-bit high resolution ALS offers
excellent sensing capabilities with sufficient selections to
fulfill most applications whether dark or high transparency
lens design. High and low interrupt thresholds can be
programmed for both ALS and PS, allowing the component
to use a minimal amount of the microcontrollers resources.

&lt;ul&gt;
Device Model created 15.06.2016 by Johannes Kolb - Vishay Semiconductor GmbH</description>
<gates>
<gate name="_VCNL4040" symbol="VCNL4040M3OE" x="0" y="-2.54"/>
</gates>
<devices>
<device name="" package="VISHAY_VCNL4040_4X2X1.1">
<connects>
<connect gate="_VCNL4040" pin="C-LED" pad="5"/>
<connect gate="_VCNL4040" pin="C-SENSOR" pad="2"/>
<connect gate="_VCNL4040" pin="GND" pad="1"/>
<connect gate="_VCNL4040" pin="INT" pad="6"/>
<connect gate="_VCNL4040" pin="SCL" pad="8"/>
<connect gate="_VCNL4040" pin="SDA" pad="7"/>
<connect gate="_VCNL4040" pin="VDD" pad="3"/>
<connect gate="_VCNL4040" pin="VDD-LED" pad="4"/>
</connects>
<technologies>
<technology name="">
<attribute name="AVAILABILITY" value="Good"/>
<attribute name="DESCRIPTION" value=" VCNL4040 Series 3.6 V 200 mm 16 Bit I2C SMT Proximity and Ambient Light Sensor "/>
<attribute name="MF" value="Vishay"/>
<attribute name="MP" value="VCNL4040M3OE"/>
<attribute name="PACKAGE" value="SMD-8 Vishay"/>
<attribute name="PRICE" value="1.34 USD"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="custom">
<packages>
<package name="R0201">
<description>&lt;b&gt;RESISTOR&lt;/b&gt; chip&lt;p&gt;
Source: http://www.vishay.com/docs/20008/dcrcw.pdf</description>
<smd name="1" x="-0.255" y="0" dx="0.28" dy="0.43" layer="1"/>
<smd name="2" x="0.255" y="0" dx="0.28" dy="0.43" layer="1"/>
<rectangle x1="-0.3" y1="-0.15" x2="-0.15" y2="0.15" layer="51"/>
<rectangle x1="0.15" y1="-0.15" x2="0.3" y2="0.15" layer="51"/>
<rectangle x1="-0.15" y1="-0.15" x2="0.15" y2="0.15" layer="21"/>
<text x="-0.508" y="0.381" size="0.4064" layer="21">&gt;NAME</text>
<text x="-0.508" y="-0.762" size="0.4064" layer="21">&gt;VALUE</text>
</package>
<package name="4_PIN_HEADER">
<pad name="4" x="0.5" y="0.5" drill="0.45"/>
<pad name="3" x="0.5" y="1.75" drill="0.45"/>
<pad name="2" x="0.5" y="3" drill="0.45"/>
<pad name="1" x="0.5" y="4.25" drill="0.45"/>
</package>
<package name="C0201">
<description>Source: http://www.avxcorp.com/docs/catalogs/cx5r.pdf</description>
<smd name="1" x="-0.25" y="0" dx="0.25" dy="0.35" layer="1"/>
<smd name="2" x="0.25" y="0" dx="0.25" dy="0.35" layer="1"/>
<text x="-0.381" y="0.254" size="0.4064" layer="25">&gt;NAME</text>
<text x="-0.381" y="-0.635" size="0.4064" layer="27">&gt;VALUE</text>
<rectangle x1="-0.3" y1="-0.15" x2="-0.15" y2="0.15" layer="51"/>
<rectangle x1="0.15" y1="-0.15" x2="0.3" y2="0.15" layer="51"/>
<rectangle x1="-0.15" y1="0.1" x2="0.15" y2="0.15" layer="51"/>
<rectangle x1="-0.15" y1="-0.15" x2="0.15" y2="-0.1" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="R-US">
<wire x1="-2.54" y1="0" x2="-2.159" y2="1.016" width="0.2032" layer="94"/>
<wire x1="-2.159" y1="1.016" x2="-1.524" y2="-1.016" width="0.2032" layer="94"/>
<wire x1="-1.524" y1="-1.016" x2="-0.889" y2="1.016" width="0.2032" layer="94"/>
<wire x1="-0.889" y1="1.016" x2="-0.254" y2="-1.016" width="0.2032" layer="94"/>
<wire x1="-0.254" y1="-1.016" x2="0.381" y2="1.016" width="0.2032" layer="94"/>
<wire x1="0.381" y1="1.016" x2="1.016" y2="-1.016" width="0.2032" layer="94"/>
<wire x1="1.016" y1="-1.016" x2="1.651" y2="1.016" width="0.2032" layer="94"/>
<wire x1="1.651" y1="1.016" x2="2.286" y2="-1.016" width="0.2032" layer="94"/>
<wire x1="2.286" y1="-1.016" x2="2.54" y2="0" width="0.2032" layer="94"/>
<text x="-3.81" y="1.4986" size="1.778" layer="95">&gt;NAME</text>
<text x="-3.81" y="-3.302" size="1.778" layer="96">&gt;VALUE</text>
<pin name="2" x="5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
<pin name="1" x="-5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1"/>
</symbol>
<symbol name="4_PIN_HEADER">
<pin name="1" x="0" y="20.32" length="middle"/>
<pin name="2" x="0" y="15.24" length="middle"/>
<pin name="3" x="0" y="10.16" length="middle"/>
<pin name="4" x="0" y="5.08" length="middle"/>
<wire x1="5.08" y1="22.86" x2="5.08" y2="2.54" width="0.254" layer="94"/>
<wire x1="5.08" y1="2.54" x2="15.24" y2="2.54" width="0.254" layer="94"/>
<wire x1="15.24" y1="2.54" x2="15.24" y2="22.86" width="0.254" layer="94"/>
<wire x1="15.24" y1="22.86" x2="5.08" y2="22.86" width="0.254" layer="94"/>
<text x="5.08" y="25.4" size="1.778" layer="94">&gt;NAME</text>
<text x="5.08" y="0" size="1.778" layer="94">&gt;VALUE</text>
</symbol>
<symbol name="C-US">
<wire x1="-2.54" y1="0" x2="2.54" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="-1.016" x2="0" y2="-2.54" width="0.1524" layer="94"/>
<wire x1="0" y1="-1" x2="2.4892" y2="-1.8542" width="0.254" layer="94" curve="-37.878202"/>
<wire x1="-2.4668" y1="-1.8504" x2="0" y2="-1.0161" width="0.254" layer="94" curve="-37.373024"/>
<text x="1.016" y="0.635" size="1.778" layer="95">&gt;NAME</text>
<text x="1.016" y="-4.191" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="0" y="2.54" visible="off" length="short" direction="pas" swaplevel="1" rot="R270"/>
<pin name="2" x="0" y="-5.08" visible="off" length="short" direction="pas" swaplevel="1" rot="R90"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="R_0201">
<gates>
<gate name="G$1" symbol="R-US" x="0" y="7.62"/>
</gates>
<devices>
<device name="" package="R0201">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="4_PIN_HEADER" prefix="4_PIN_HEADER" uservalue="yes">
<gates>
<gate name="G$1" symbol="4_PIN_HEADER" x="7.62" y="5.08"/>
</gates>
<devices>
<device name="" package="4_PIN_HEADER">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
<connect gate="G$1" pin="3" pad="3"/>
<connect gate="G$1" pin="4" pad="4"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="C_0201">
<gates>
<gate name="G$1" symbol="C-US" x="0" y="10.16"/>
</gates>
<devices>
<device name="" package="C0201">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="supply1" urn="urn:adsk.eagle:library:371">
<description>&lt;b&gt;Supply Symbols&lt;/b&gt;&lt;p&gt;
 GND, VCC, 0V, +5V, -5V, etc.&lt;p&gt;
 Please keep in mind, that these devices are necessary for the
 automatic wiring of the supply signals.&lt;p&gt;
 The pin name defined in the symbol is identical to the net which is to be wired automatically.&lt;p&gt;
 In this library the device names are the same as the pin names of the symbols, therefore the correct signal names appear next to the supply symbols in the schematic.&lt;p&gt;
 &lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
</packages>
<symbols>
<symbol name="GND" urn="urn:adsk.eagle:symbol:26925/1" library_version="1">
<wire x1="-1.905" y1="0" x2="1.905" y2="0" width="0.254" layer="94"/>
<text x="-2.54" y="-2.54" size="1.778" layer="96">&gt;VALUE</text>
<pin name="GND" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
<symbol name="VCC" urn="urn:adsk.eagle:symbol:26928/1" library_version="1">
<wire x1="1.27" y1="-1.905" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="-1.27" y2="-1.905" width="0.254" layer="94"/>
<text x="-2.54" y="-2.54" size="1.778" layer="96" rot="R90">&gt;VALUE</text>
<pin name="VCC" x="0" y="-2.54" visible="off" length="short" direction="sup" rot="R90"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="GND" urn="urn:adsk.eagle:component:26954/1" prefix="GND" library_version="1">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="GND" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="VCC" urn="urn:adsk.eagle:component:26957/1" prefix="P+" library_version="1">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="VCC" symbol="VCC" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="U1" library="VCNL4040M3OE" deviceset="VCNL4040M3OE" device=""/>
<part name="R1" library="custom" deviceset="R_0201" device="" value="2.2K"/>
<part name="R2" library="custom" deviceset="R_0201" device="" value="2.2K"/>
<part name="4_PIN_HEADER1" library="custom" deviceset="4_PIN_HEADER" device=""/>
<part name="C2" library="custom" deviceset="C_0201" device="" value="2.2uF"/>
<part name="C1" library="custom" deviceset="C_0201" device="" value="0.1uF"/>
<part name="GND1" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND2" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND3" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="P+1" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="VCC" device=""/>
<part name="P+2" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="VCC" device=""/>
<part name="P+3" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="VCC" device=""/>
<part name="P+4" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="VCC" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="U1" gate="_VCNL4040" x="68.58" y="45.72"/>
<instance part="R1" gate="G$1" x="99.06" y="60.96" rot="R90"/>
<instance part="R2" gate="G$1" x="106.68" y="55.88" rot="R90"/>
<instance part="4_PIN_HEADER1" gate="G$1" x="142.24" y="53.34"/>
<instance part="C2" gate="G$1" x="35.56" y="30.48"/>
<instance part="C1" gate="G$1" x="22.86" y="40.64"/>
<instance part="GND1" gate="1" x="22.86" y="27.94"/>
<instance part="GND2" gate="1" x="35.56" y="17.78"/>
<instance part="GND3" gate="1" x="12.7" y="50.8"/>
<instance part="P+1" gate="VCC" x="99.06" y="73.66"/>
<instance part="P+2" gate="VCC" x="106.68" y="68.58"/>
<instance part="P+3" gate="VCC" x="22.86" y="48.26"/>
<instance part="P+4" gate="VCC" x="35.56" y="38.1"/>
</instances>
<busses>
</busses>
<nets>
<net name="VCC" class="0">
<segment>
<pinref part="U1" gate="_VCNL4040" pin="VDD"/>
<pinref part="C1" gate="G$1" pin="1"/>
<wire x1="50.8" y1="43.18" x2="22.86" y2="43.18" width="0.1524" layer="91"/>
<pinref part="P+3" gate="VCC" pin="VCC"/>
<wire x1="22.86" y1="43.18" x2="22.86" y2="45.72" width="0.1524" layer="91"/>
<junction x="22.86" y="43.18"/>
</segment>
<segment>
<pinref part="U1" gate="_VCNL4040" pin="VDD-LED"/>
<pinref part="P+4" gate="VCC" pin="VCC"/>
<wire x1="50.8" y1="38.1" x2="50.8" y2="35.56" width="0.1524" layer="91"/>
<wire x1="50.8" y1="35.56" x2="35.56" y2="35.56" width="0.1524" layer="91"/>
<pinref part="C2" gate="G$1" pin="1"/>
<wire x1="35.56" y1="35.56" x2="35.56" y2="33.02" width="0.1524" layer="91"/>
<junction x="35.56" y="35.56"/>
</segment>
<segment>
<pinref part="P+2" gate="VCC" pin="VCC"/>
<pinref part="R2" gate="G$1" pin="2"/>
<wire x1="106.68" y1="66.04" x2="106.68" y2="60.96" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="P+1" gate="VCC" pin="VCC"/>
<pinref part="R1" gate="G$1" pin="2"/>
<wire x1="99.06" y1="71.12" x2="99.06" y2="66.04" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="4_PIN_HEADER1" gate="G$1" pin="4"/>
<wire x1="142.24" y1="58.42" x2="129.54" y2="58.42" width="0.1524" layer="91"/>
<label x="129.54" y="58.42" size="1.778" layer="95"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<pinref part="C1" gate="G$1" pin="2"/>
<pinref part="GND1" gate="1" pin="GND"/>
<wire x1="22.86" y1="35.56" x2="22.86" y2="30.48" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C2" gate="G$1" pin="2"/>
<pinref part="GND2" gate="1" pin="GND"/>
<wire x1="35.56" y1="25.4" x2="35.56" y2="20.32" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="U1" gate="_VCNL4040" pin="GND"/>
<pinref part="GND3" gate="1" pin="GND"/>
<wire x1="50.8" y1="53.34" x2="12.7" y2="53.34" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="4_PIN_HEADER1" gate="G$1" pin="3"/>
<wire x1="142.24" y1="63.5" x2="129.54" y2="63.5" width="0.1524" layer="91"/>
<label x="129.54" y="63.5" size="1.778" layer="95"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="U1" gate="_VCNL4040" pin="C-SENSOR"/>
<wire x1="50.8" y1="48.26" x2="43.18" y2="48.26" width="0.1524" layer="91"/>
<wire x1="43.18" y1="48.26" x2="43.18" y2="63.5" width="0.1524" layer="91"/>
<wire x1="43.18" y1="63.5" x2="88.9" y2="63.5" width="0.1524" layer="91"/>
<wire x1="88.9" y1="63.5" x2="88.9" y2="38.1" width="0.1524" layer="91"/>
<pinref part="U1" gate="_VCNL4040" pin="C-LED"/>
<wire x1="88.9" y1="38.1" x2="86.36" y2="38.1" width="0.1524" layer="91"/>
</segment>
</net>
<net name="SCL" class="0">
<segment>
<pinref part="4_PIN_HEADER1" gate="G$1" pin="1"/>
<wire x1="142.24" y1="73.66" x2="129.54" y2="73.66" width="0.1524" layer="91"/>
<label x="129.54" y="73.66" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="R1" gate="G$1" pin="1"/>
<wire x1="99.06" y1="55.88" x2="99.06" y2="53.34" width="0.1524" layer="91"/>
<pinref part="U1" gate="_VCNL4040" pin="SCL"/>
<wire x1="99.06" y1="53.34" x2="86.36" y2="53.34" width="0.1524" layer="91"/>
<label x="91.44" y="53.34" size="1.778" layer="95"/>
</segment>
</net>
<net name="SDA" class="0">
<segment>
<pinref part="4_PIN_HEADER1" gate="G$1" pin="2"/>
<wire x1="142.24" y1="68.58" x2="129.54" y2="68.58" width="0.1524" layer="91"/>
<label x="129.54" y="68.58" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U1" gate="_VCNL4040" pin="SDA"/>
<pinref part="R2" gate="G$1" pin="1"/>
<wire x1="86.36" y1="48.26" x2="106.68" y2="48.26" width="0.1524" layer="91"/>
<wire x1="106.68" y1="48.26" x2="106.68" y2="50.8" width="0.1524" layer="91"/>
<label x="91.44" y="48.26" size="1.778" layer="95"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
<compatibility>
<note version="8.2" severity="warning">
Since Version 8.2, EAGLE supports online libraries. The ids
of those online libraries will not be understood (or retained)
with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports URNs for individual library
assets (packages, symbols, and devices). The URNs of those assets
will not be understood (or retained) with this version.
</note>
</compatibility>
</eagle>
