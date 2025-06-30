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
          maxFiles: 10, // Optional: limit number of files
        },
      },
    },
      // Add the new configuration for users-permissions alongside the upload config
  'users-permissions': {
    config: {
      register: {
        // This explicitly tells Strapi that no extra fields can be
        // passed during user registration, resolving the warning.
        allowedFields: [],
      },
    },
  },

  });