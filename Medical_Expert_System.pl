% Knowledge base with symptoms and corresponding illnesses
symptom(fever, flu).
symptom(cough, flu).
symptom(sore_throat, flu).
symptom(runny_nose, flu).
symptom(fatigue, flu).
symptom(headache, flu).
symptom(body_ache, flu).
symptom(chills, flu).

symptom(rash, measles).
symptom(high_fever, measles).
symptom(cough, measles).
symptom(conjunctivitis, measles).
symptom(runny_nose, measles).
symptom(koplik_spots, measles).

symptom(sore_throat, cold).
symptom(cough, cold).
symptom(runny_nose, cold).
symptom(sneezing, cold).
symptom(nasal_congestion, cold).
symptom(mild_fever, cold).
symptom(headache, cold).

symptom(stomach_pain, food_poisoning).
symptom(vomiting, food_poisoning).
symptom(diarrhea, food_poisoning).
symptom(nausea, food_poisoning).
symptom(abdominal_cramps, food_poisoning).

symptom(chest_pain, heart_attack).
symptom(shortness_of_breath, heart_attack).
symptom(dizziness, heart_attack).
symptom(fatigue, heart_attack).
symptom(nausea, heart_attack).
symptom(sweating, heart_attack).

% Examples of patients and their symptoms
has_symptom(ali, fever).
has_symptom(ali, cough).
has_symptom(ali, sore_throat).
has_symptom(ali, runny_nose).
has_symptom(ali, fatigue).
has_symptom(ali, headache).
has_symptom(ali, body_ache).
has_symptom(ali, chills).

has_symptom(fatima, sore_throat).
has_symptom(fatima, cough).
has_symptom(fatima, runny_nose).
has_symptom(fatima, sneezing).
has_symptom(fatima, headache).
has_symptom(fatima, chills).
has_symptom(fatima, body_ache).
has_symptom(fatima, nasal_congestion).

has_symptom(mohammed, rash).
has_symptom(mohammed, high_fever).
has_symptom(mohammed, cough).
has_symptom(mohammed, conjunctivitis).
has_symptom(mohammed, runny_nose).
has_symptom(mohammed, koplik_spots).
has_symptom(mohammed, body_ache).
has_symptom(mohammed, chills).

has_symptom(aysha, sore_throat).
has_symptom(aysha, cough).
has_symptom(aysha, fatigue).
has_symptom(aysha, headache).
has_symptom(aysha, chills).
has_symptom(aysha, body_ache).
has_symptom(aysha, nasal_congestion).

has_symptom(nour, fever).
has_symptom(nour, headache).
has_symptom(nour, chills).
has_symptom(nour, body_ache).
has_symptom(nour, fatigue).
has_symptom(nour, nasal_congestion).

has_symptom(ahmed, fever).
has_symptom(ahmed, cough).
has_symptom(ahmed, headache).
has_symptom(ahmed, runny_nose).
has_symptom(ahmed, sneezing).
has_symptom(ahmed, chills).
has_symptom(ahmed, body_ache).
has_symptom(ahmed, nasal_congestion).

has_symptom(aminah, sore_throat).
has_symptom(aminah, cough).
has_symptom(aminah, runny_nose).
has_symptom(aminah, sneezing).
has_symptom(aminah, chills).
has_symptom(aminah, body_ache).
has_symptom(aminah, headache).
                                                                 
has_symptom(aminah, nasal_congestion).
has_symptom(khalid, fatigue).
has_symptom(khalid, cough).
has_symptom(khalid, runny_nose).
has_symptom(khalid, sneezing).
has_symptom(khalid, chills).
has_symptom(khalid, body_ache).
has_symptom(khalid, headache).
has_symptom(khalid, nasal_congestion).
                                                                 
has_symptom(nadia, rash).
has_symptom(nadia, high_fever).
has_symptom(nadia, cough).
has_symptom(nadia, conjunctivitis).
has_symptom(nadia, runny_nose).
has_symptom(nadia, koplik_spots).
has_symptom(nadia, body_ache).
has_symptom(nadia, chills).
                                                                 
has_symptom(farah, sore_throat).
has_symptom(farah, cough).
has_symptom(farah, runny_nose).
has_symptom(farah, sneezing).
has_symptom(farah, chills).
has_symptom(farah, body_ache).
has_symptom(farah, headache).
has_symptom(farah, nasal_congestion).
                                                                 
has_symptom(salah, fever).
has_symptom(salah, headache).
has_symptom(salah, chills).
has_symptom(salah, body_ache).
has_symptom(salah, fatigue).
has_symptom(salah, sweating).



% Rules for diagnosing illnesses based on symptoms
diagnose_illness(Patient, Illness, Likelihood) :-
    setof(Count-I, match_illness(Patient, I, Count), Illnesses),
    reverse(Illnesses, ReversedIllnesses),
    member(Count-Illness, ReversedIllnesses),
    count_total_symptoms(Patient, Total),
    Likelihood is (Count / Total) * 100.

match_illness(Patient, Illness, Count) :-
    symptom(S, Illness),
    has_symptom(Patient, S),
    count_matching_symptoms(Patient, Illness, Count).

count_matching_symptoms(Patient, Illness, Count) :-
    findall(S, (has_symptom(Patient, S), symptom(S, Illness)), Symptoms),
    length(Symptoms, Count).

count_total_symptoms(Patient, Total) :-
    findall(S, has_symptom(Patient, S), Symptoms),
    length(Symptoms, Total).

print_diagnosis(Patient) :-
    diagnose_illness(Patient, Illness, Likelihood),
    format("~w: ~1f% likelihood~n", [Illness, Likelihood]).

