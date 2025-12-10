#seed-topics2.sh
#!/usr/bin/env bash

# --- set your creds ---
export STRAPI_URL="http://localhost:1338"
export STRAPI_TOKEN="949394799a60ba70219293f2188419a00d55c8105032a35037e2405a68e9b00b18c08a53fb60b39d989e68941abb0622846b2e4edc2e5181bd6b2d26bd4a1ada8c1078758d05960c310cf214cd748ddce3ae276f5aa859e681a7d11e30a6c360de5f6d005e631ab77d4de360ee5bfcc4f1890b8bfe9e443dc030879b89663fa0"   # paste your token

hdr=(-H "Authorization: Bearer $STRAPI_TOKEN" -H "Content-Type: application/json")

echo "→ Using $STRAPI_URL"

echo "[1/9] Introduce your family"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Introduce your family",
    "description": "Say who is in your family. Example: I have a mother and a father. I have one sister.",
    "tags": "A1,beginner,family,have-has",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 2
  }
}'

echo
echo "[2/9] Introduce your extended family"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Introduce your extended family",
    "description": "Talk about cousins, aunts, uncles, and grandparents. Example: My aunt lives in Vancouver.",
    "tags": "A1,beginner,family,extended-family",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 2
  }
}'

echo
echo "[3/9] Describe a family member"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Describe a family member",
    "description": "Use be + adjectives and hair/eyes: She is kind. He is tall. She has long hair.",
    "tags": "A1,beginner,family,adjectives,appearance",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 2
  }
}'

echo
echo "[4/9] Household roles and chores in your family"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Household roles and chores in your family",
    "description": "Who does what at home: I cook on Monday. My brother washes the dishes. We clean the living room.",
    "tags": "A1,beginner,home,chores,routine",
    "is_active": true,
    "mode_hint": "scenario",
    "difficulty_level": 1,
    "cefr_syllabus": 2
  }
}'

echo
echo "[5/9] Talking about your best friend"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Talking about your best friend",
    "description": "Say their name, age, where they are from, and what they like: My best friend is Anna. She is 20. She is from Mexico. She likes music.",
    "tags": "A1,beginner,friends,likes,be-from",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 2
  }
}'

echo
echo "[6/9] Talk about a family celebration"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Talk about a family celebration",
    "description": "Describe a birthday or holiday at home: We have cake. We invite family. We take photos.",
    "tags": "A1,beginner,celebrations,party,home",
    "is_active": true,
    "mode_hint": "scenario",
    "difficulty_level": 1,
    "cefr_syllabus": 2
  }
}'

echo
echo "[7/9] How your family celebrates Christmas or another festival"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "How your family celebrates Christmas or another festival",
    "description": "Describe simple traditions: We decorate the tree. We visit family. Or talk about another festival your family celebrates.",
    "tags": "A1,beginner,festival,traditions,christmas",
    "is_active": true,
    "mode_hint": "scenario",
    "difficulty_level": 1,
    "cefr_syllabus": 2
  }
}'

echo
echo "[8/9] Pets in your family"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Pets in your family",
    "description": "Do you have a pet? What is its name? What does it like? Example: I have a dog. His name is Max. He likes chicken.",
    "tags": "A1,beginner,pets,have-has,possessive-s",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 2
  }
}'

echo
echo "[9/9] Solving problems in your family"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Solving problems in your family",
    "description": "Make polite requests, say feelings, suggest solutions, and apologize. Examples: Can you help me please? Sorry, I cannot. Maybe later. Let us clean the living room.",
    "tags": "A1,beginner,family,polite-requests,problems",
    "is_active": true,
    "mode_hint": "scenario",
    "difficulty_level": 1,
    "cefr_syllabus": 2
  }
}'
echo
echo "✔ Done."
