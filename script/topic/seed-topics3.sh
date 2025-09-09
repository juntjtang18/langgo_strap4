#!/usr/bin/env bash

# --- set your creds (using your session token) ---
export STRAPI_URL="http://localhost:1338"
export STRAPI_TOKEN="949394799a60ba70219293f2188419a00d55c8105032a35037e2405a68e9b00b18c08a53fb60b39d989e68941abb0622846b2e4edc2e5181bd6b2d26bd4a1ada8c1078758d05960c310cf214cd748ddce3ae276f5aa859e681a7d11e30a6c360de5f6d005e631ab77d4de360ee5bfcc4f1890b8bfe9e443dc030879b89663fa0"

hdr=(-H "Authorization: Bearer $STRAPI_TOKEN" -H "Content-Type: application/json")

echo "→ Using $STRAPI_URL (Daily routines, CEFR 3)"

echo "[1/11] Your morning routine"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Your morning routine",
    "description": "Say what you do in the morning: I wake up at 7. I brush my teeth. I eat breakfast.",
    "tags": "A1,beginner,daily-routine,morning,sequence",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 3
  }
}'

echo
echo "[2/11] Getting to school or work"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Getting to school or work",
    "description": "Talk about transport and time: I take the bus at 8. I walk to the station. I arrive at 9.",
    "tags": "A1,beginner,daily-routine,transport,go-to",
    "is_active": true,
    "mode_hint": "scenario",
    "difficulty_level": 1,
    "cefr_syllabus": 3
  }
}'

echo
echo "[3/11] Your basic tasks in class or at work"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Your basic tasks in class or at work",
    "description": "Say simple tasks: I read. I write. I have a meeting. I send emails.",
    "tags": "A1,beginner,school,work,tasks",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 3
  }
}'

echo
echo "[4/11] Lunch"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Lunch",
    "description": "What do you eat and when: I have lunch at 12. I eat rice and soup. I drink tea.",
    "tags": "A1,beginner,food,drinks,lunch",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 3
  }
}'

echo
echo "[5/11] Afternoon activities"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Afternoon activities",
    "description": "Say what you do in the afternoon: I study. I do homework. I go shopping.",
    "tags": "A1,beginner,afternoon,study,errands",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 3
  }
}'

echo
echo "[6/11] Evening routine"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Evening routine",
    "description": "Talk about your evening: I have dinner. I watch TV. I read a book. I relax.",
    "tags": "A1,beginner,evening,relax,routine",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 3
  }
}'

echo
echo "[7/11] Your weekend"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Your weekend",
    "description": "Say weekend plans and activities: On Saturday, I visit friends. On Sunday, I rest at home.",
    "tags": "A1,beginner,weekend,plans,days-of-week",
    "is_active": true,
    "mode_hint": "scenario",
    "difficulty_level": 1,
    "cefr_syllabus": 3
  }
}'

echo
echo "[8/11] Your exercise and health habits"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Your exercise and health habits",
    "description": "Talk about exercise: I walk every day. I run on Tuesday. I sometimes go to the gym.",
    "tags": "A1,beginner,exercise,health,frequency",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 3
  }
}'

echo
echo "[9/11] Your screen time or hobbies after school or work"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Your screen time or hobbies after school or work",
    "description": "Say what you do after school or work: I play games for 30 minutes. I listen to music. I watch videos.",
    "tags": "A1,beginner,hobbies,screen-time,after-school",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 3
  }
}'

echo
echo "[10/11] Your daily schedule"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Your daily schedule",
    "description": "Build a simple timetable: I get up at 7. I work at 9. I have dinner at 7. I go to bed at 10.",
    "tags": "A1,beginner,time,schedule,timetable",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 3
  }
}'

echo
echo "[11/11] Dinner"
curl -i -X POST "$STRAPI_URL/api/topics" "${hdr[@]}" -d '{
  "data": {
    "title": "Dinner",
    "description": "Talk about dinner: We have rice and vegetables. We eat at 7 pm. After dinner, we talk.",
    "tags": "A1,beginner,food,drinks,dinner",
    "is_active": true,
    "mode_hint": "practice",
    "difficulty_level": 1,
    "cefr_syllabus": 3
  }
}'
echo
echo "✔ Done."
