// config/plugins.js
module.exports = () => ({
  upload: {
    config: {
      provider: '@strapi-community/strapi-provider-upload-google-cloud-storage',
      providerOptions: {
        bucketName: 'langgo-en-storage',
        publicFiles: true,
        uniform: false,
        basePath: '',
      },
      sizeLimit: 1024 * 1024 * 1024, // 1GB
      formidable: {
        maxFileSize: 1024 * 1024 * 1024, // 1GB
        maxFiles: 10,
      },
    },
  },

  'users-permissions': {
    config: {
      register: {
        allowedFields: [],
      },
    },
  },

});
