const fs = require('fs');
const axios = require('axios');

const API_URL = 'http://localhost:1338/api/user-words';
const ADMIN_TOKEN='6538d1356589b1535b2c97bc0e76cbe58ffbcaa8087558527ee0b37af5cefa195795b37839fdd885c3cbe624d7e38298130cc787eebd43f60748cd20cab040885dd334b6c88b2201ae2793ad08164177aeadff42f2c13bde3500db72abd0cb477d78e3f2c5d6b8e7073c8021be966076ba288e91d211b9063ec657199fd5fce9';

const headers = {
  Authorization: `Bearer ${ADMIN_TOKEN}`,
  'Content-Type': 'application/json',
};

async function fetchAllUserWords() {
  const allItems = [];
  let page = 1;
  const pageSize = 100;

  while (true) {
    const res = await axios.get(API_URL, {
      headers,
      params: {
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    });

    const data = res.data.data;
    allItems.push(...data);

    const meta = res.data.meta.pagination;
    if (page * pageSize >= meta.total) {
      break;
    }

    page++;
  }

  return allItems;
}

(async () => {
  const items = await fetchAllUserWords();
  fs.writeFileSync('user_words_backup.json', JSON.stringify({ data: items }, null, 2));
  console.log(`✅ Saved ${items.length} user words`);
})();
