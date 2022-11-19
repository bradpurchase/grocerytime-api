class RemoveRefreshTokenAndExpiresInFromAuthTokens < ActiveRecord::Migration[7.0]
  def change
    remove_column :auth_tokens, :refresh_token
    remove_column :auth_tokens, :expires_in
  end
end
