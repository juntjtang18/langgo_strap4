#!/usr/bin/env bash

# --- set your creds (session token embedded) ---
export STRAPI_URL="http://localhost:1338"
export STRAPI_TOKEN="949394799a60ba70219293f2188419a00d55c8105032a35037e2405a68e9b00b18c08a53fb60b39d989e68941abb0622846b2e4edc2e5181bd6b2d26bd4a1ada8c1078758d05960c310cf214cd748ddce3ae276f5aa859e681a7d11e30a6c360de5f6d005e631ab77d4de360ee5bfcc4f1890b8bfe9e443dc030879b89663fa0"

hdr=(-H "Authorization: Bearer $STRAPI_TOKEN" -H "Content-Type: application/json")

echo "→ Using $STRAPI_URL (Shopping, CEFR 5)"

echo "[1/3] Buying clothes"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Buying clothes",
    "description": "Practice size, color, and fit when shopping for clothes and shoes. Example: Do you have this shirt in size M in blue? Can I try these jeans? The shoes are size 8. They are too small.",
    "tags": "A1,beginner,shopping,clothes,sizes,colors,fitting-room",
    "is_active": true,
    "mode_hint": "scenario",
    "difficulty_level": 1,
    "cefr_syllabus": 5
  }
}'

echo
echo "[2/3] Return or exchange"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Return or exchange",
    "description": "Handle a simple return or exchange. Example: I would like to exchange this. It does not fit. Here is the receipt. Can I get a larger size?",
    "tags": "A1,beginner,shopping,returns,exchanges,receipt",
    "is_active": true,
    "mode_hint": "scenario",
    "difficulty_level": 1,
    "cefr_syllabus": 5
  }
}'

echo
echo "[3/3] Shopping"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Shopping",
    "description": "General shopping conversation. Make a list, ask for help, find items, ask prices, and pay. Example: Excuse me, I am looking for socks. How much is this? Can I pay by card?",
    "tags": "A1,beginner,shopping,prices,help,payment",
    "is_active": true,
    "mode_hint": "scenario",
    "difficulty_level": 2,
    "cefr_syllabus": 5
  }
}'
echo
echo "✔ Done."
