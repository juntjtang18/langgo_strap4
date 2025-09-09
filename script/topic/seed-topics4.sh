#!/usr/bin/env bash

# --- set your creds (session token embedded) ---
export STRAPI_URL="http://localhost:1338"
export STRAPI_TOKEN="949394799a60ba70219293f2188419a00d55c8105032a35037e2405a68e9b00b18c08a53fb60b39d989e68941abb0622846b2e4edc2e5181bd6b2d26bd4a1ada8c1078758d05960c310cf214cd748ddce3ae276f5aa859e681a7d11e30a6c360de5f6d005e631ab77d4de360ee5bfcc4f1890b8bfe9e443dc030879b89663fa0"

hdr=(-H "Authorization: Bearer $STRAPI_TOKEN" -H "Content-Type: application/json")

echo "→ Using $STRAPI_URL (Food & Drinks, CEFR 4)"

echo "[1/9] Fruits and vegetables"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Fruits and vegetables",
    "description": "Name common fruits and vegetables. Example: I like apples, bananas, and carrots.",
    "tags": "A1,beginner,food,fruits,vegetables",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 4
  }
}'

echo
echo "[2/9] Drinks and beverages"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Drinks and beverages",
    "description": "Talk about drinks: water, tea, coffee, juice, milk. Example: I drink coffee in the morning.",
    "tags": "A1,beginner,drinks,beverages,hot-cold",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 4
  }
}'

echo
echo "[3/9] Breakfast choices"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Breakfast choices",
    "description": "Say what you have for breakfast and when. Example: I have eggs and toast at 8 am.",
    "tags": "A1,beginner,breakfast,have-food,time",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 4
  }
}'

echo
echo "[4/9] Your favorite food or dishes"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Your favorite food or dishes",
    "description": "Describe your favorite food and why you like it. Example: My favorite dish is pizza because it is tasty.",
    "tags": "A1,beginner,favorites,likes,food",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 4
  }
}'

echo
echo "[5/9] Tastes and textures of food"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Tastes and textures of food",
    "description": "Use words like sweet, salty, sour, spicy, bitter, soft, and crispy to describe food.",
    "tags": "A1,beginner,taste,texture,adjectives",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 4
  }
}'

echo
echo "[6/9] Ordering at a cafe"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Ordering at a cafe",
    "description": "Role-play ordering: I would like a coffee, please. Can I have a sandwich? Thanks.",
    "tags": "A1,beginner,cafe,ordering,polite-requests",
    "is_active": true,
    "mode_hint": "scenario",
    "difficulty_level": 1,
    "cefr_syllabus": 4
  }
}'

echo
echo "[7/9] Ordering at a restaurant"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Ordering at a restaurant",
    "description": "Practice menu items and asking for the bill: I would like the soup. The bill, please.",
    "tags": "A1,beginner,restaurant,menu,bill",
    "is_active": true,
    "mode_hint": "scenario",
    "difficulty_level": 1,
    "cefr_syllabus": 4
  }
}'

echo
echo "[8/9] Cooking"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Cooking",
    "description": "Use simple cooking verbs and steps: cut, mix, boil, fry. Example: First, cut the tomato. Then, mix the salad.",
    "tags": "A1,beginner,cooking,verbs,recipes",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 4
  }
}'

echo
echo "[9/9] Quantities of foods"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Quantities of foods",
    "description": "Use a cup of, a bottle of, a slice of, a piece of, some, and a to talk about amounts.",
    "tags": "A1,beginner,quantities,containers,count-noncount",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 4
  }
}'
echo
echo "✔ Done."
