%
% FSTs for nominal inflections - plurals
%

#include "../symbols.fst"

ALPHABET = [#Letters##POS##BM##TMP##Numbers#] <plural> <pl> <del>

%%%%% plural
% തലകൾ, തരങ്ങൾ, കാടുകൾ
$plural-maps$ = {[#Virama#]} : {ുകൾ} | \
	{[#Anuswara#]} : {ങ്ങൾ} | \
	{[ൻ]} : {ൻമാർ} | \
	{[ൽ]} : {ലുകൾ}  | \
	{[ൾ]} : {ളുകൾ} | \
	{[ൺ]} : {ണുുകൾ} | \
	{[ർ]} : {റുകൾ} | \
	{[ർ]} : {രുകൾ} | \
	{ഞാൻ} : {ഞങ്ങൾ} | \
	{നീ} : {നിങ്ങൾ} | \
	{കായ്} : {കായ്കൾ} | \
	{നിഘണ്ടു} : {നിഘണ്ടുക്കൾ} | \
	{സുഹൃത്ത്} : {സുഹൃത്തുക്കൾ} | \
	{ക്താവ്} : {ക്താക്കൾ} |\
	{മനുഷ്യൻ}: {മനുഷ്യർ}

$plural-general_step1$ = $plural-maps$ <>:<del> ^-> (__ [#POS##BM##TMP##Numbers#]+ <pl> )
$plural-del-tmp$ = {<pl>}:{} ^-> ( <del> [#POS##BM##TMP##Numbers#]+ __ )
$plural-general$= $plural-general_step1$ || $plural-del-tmp$

% ഒാഷ്ഠ്യസ്വരമാകാത്തിടത്തോ ഖരാക്ഷരങ്ങളിലോ അവസാനിക്കുന്നവയുടെ കൂടെ കൾ ചേർത്താൽ
% ബഹുവചനം കിട്ടും. ഈ കൾ-ലെ ക ഫോണോളജിക്കൽ നിയമങ്ങളിൽ നിന്ന് വിട്ട് നിൽക്കണം.
% "കൾ' എന്ന പ്രത്യയത്തിന്റെ മുമ്പിലുള്ള വർണ്ണം ഒാഷ്ഠ്യസ്വരമാകുന്നിടത്തെല്ലാം അതിലെ ("കൾ' എന്നതിലെ) കകാരം ഇരട്ടിക്കും.

% <plural> Marks need to insert to avoid phonological rules in boundaries.
% for example: പൂച്ച + കൾ = പൂച്ചകൾ and not പൂച്ചക്കൾ as in പൂച്ച + കല്ല് => പൂച്ചക്കല്ല്
#VowelSigns-labial# = ുൂൊോാ
#VowelSigns-non-labial# = ിീൃെേ
$plural-cons-vowel$ = {<pl>}:{<plural>കൾ} ^-> ([#Consonants##VowelSigns-non-labial#] [#POS##BM##TMP#]+ __ )
% പശു - പശുക്കൾ, ഗുരു-ഗുരുക്കൾ
$plural-u-vowelsign$ = {<pl>}:{<plural>ക്കൾ} ^-> ( [#VowelSigns-labial#] [#POS##BM##TMP#]+ __ )

$plural$ = $plural-general$ || $plural-cons-vowel$ || $plural-u-vowelsign$

% പുരുഷന്മാരോ സ്ത്രീകളോ വെവ്വേറെ ചേർന്നുണ്ടാകുന്ന ബഹുത്വത്തെക്കുറിക്കുന്ന സലിംഗബഹുവചനപ്രത്യയം സാമാന്യമായി "മാർ' എന്നാണു്.
% ഉദാ: രാമൻ-രാമന്മാർ, നമ്പൂരി-നമ്പൂരിമാർ, തട്ടാൻ-തട്ടാന്മാർ അമ്മ-അമ്മമാർ, ഭാര്യ-ഭാര്യമാർ തള്ള-തള്ളമാർ. മന്ത്രിമാർ?
% പുരുഷന്മാരും സ്ത്രീകളുംകൂടിയുണ്ടാകുന്ന ബഹുത്വത്തെക്കുറിപ്പാനുള്ള അലിംഗബഹുവചനപ്രത്യയം "അർ' എന്നാകുന്നു.
% ഉദാ: മിടുക്കർ, ശൂദ്രർ, അധ്യാപകർ, പോലീസുകാർ(പോലീസുകാരൻ + പോലീസുകാരി)
% Looks like we need gender tagging in lexicon.

$test$ = മല<n><pl> | അവൻ<n><pl> | മരം<n><pl> | ഇതൾ<n><pl> | മുകിൽ<n><pl> | പയർ<n><pl> | <LB>പതിനഞ്ച്<RB><cardinal><pl>
$test$ || $plural$ >> "plural-test.a"

$plural$
