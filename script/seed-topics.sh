# Optional: set once, then paste the rest
TOKEN="949394799a60ba70219293f2188419a00d55c8105032a35037e2405a68e9b00b18c08a53fb60b39d989e68941abb0622846b2e4edc2e5181bd6b2d26bd4a1ada8c1078758d05960c310cf214cd748ddce3ae276f5aa859e681a7d11e30a6c360de5f6d005e631ab77d4de360ee5bfcc4f1890b8bfe9e443dc030879b89663fa0"
BASE="http://localhost:1338"

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"Self-introduction (name, age, nationality)","description":"Say your name and age; tell where you are from: I am James. I am 20. I am Canadian.","tags":"A1,beginner,self-introduction,personal","is_active":true,"mode_hint":"practice","difficulty_level":1,"cefr_syllabus":1}}'

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"My hobbies","description":"Talk about free-time activities with like/dont like: I like reading. I dont like running.","tags":"A1,beginner,hobbies,likes","is_active":true,"mode_hint":"practice","difficulty_level":1,"cefr_syllabus":1}}'

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"The music I like","description":"Share favorite music, singers, and instruments: I like pop music. My favorite singer is ...","tags":"A1,beginner,music,likes","is_active":true,"mode_hint":"practice","difficulty_level":1,"cefr_syllabus":1}}'

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"Nationalities & countries","description":"Connect country and nationality: I am from Brazil. I am Brazilian.","tags":"A1,beginner,nationality,country","is_active":true,"mode_hint":"practice","difficulty_level":1,"cefr_syllabus":1}}'

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"My family","description":"Introduce close family members: I have a brother and a sister. My mother is Anna.","tags":"A1,beginner,family,possessives","is_active":true,"mode_hint":"practice","difficulty_level":1,"cefr_syllabus":1}}'

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"My daily routine","description":"Describe simple day steps with present simple: I wake up at 7. I go to school. I eat lunch at 12.","tags":"A1,beginner,routine,time","is_active":true,"mode_hint":"scenario","difficulty_level":1,"cefr_syllabus":1}}'

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"My favorite food and drinks","description":"Use I like / I dont like for foods: I like pizza. I dont like coffee.","tags":"A1,beginner,food,drinks,likes","is_active":true,"mode_hint":"practice","difficulty_level":1,"cefr_syllabus":1}}'

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"My school or work","description":"Basic role and place: I am a student. I work in a shop. Introduce teacher/coworker names.","tags":"A1,beginner,school,work","is_active":true,"mode_hint":"practice","difficulty_level":1,"cefr_syllabus":1}}'

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"My friends","description":"Describe a friend simply: age, country, likes: He is 20. He is from Mexico. He likes football.","tags":"A1,beginner,friends,descriptions","is_active":true,"mode_hint":"practice","difficulty_level":1,"cefr_syllabus":1}}'

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"The weather today","description":"Say todays weather and preferences: It is sunny. It is cold. I like summer.","tags":"A1,beginner,weather,small-talk","is_active":true,"mode_hint":"practice","difficulty_level":1,"cefr_syllabus":1}}'

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"My favorite color and clothes","description":"State color/clothing preferences: My favorite color is blue. I like T-shirts and jeans.","tags":"A1,beginner,colors,clothes,likes","is_active":true,"mode_hint":"practice","difficulty_level":1,"cefr_syllabus":1}}'

curl -i -X POST "$BASE/api/topics" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"data":{"title":"Where I live","description":"Say your city and home type: I live in Toronto. My house is small. My city is big.","tags":"A1,beginner,home,city","is_active":true,"mode_hint":"practice","difficulty_level":1,"cefr_syllabus":1}}'
