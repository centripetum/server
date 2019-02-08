module.exports = {
  options: {
    connection: process.env.CP_DATABASE_URL,
    schema: ['app_public', 'app_private', 'app_hidden', 'app_jobs'],
    jwtSecret: 'notsosecret',
    defaultRole: 'cp_anonymous',
    jwtTokenIdentifier: 'app_public.jwt_token',
    watch: true
  }
}
