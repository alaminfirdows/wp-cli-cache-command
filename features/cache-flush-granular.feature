Feature: Granular cache flushing operations

  @skip-object-cache
  Scenario: Flush post cache
    Given a WP install
    And a wp-content/mu-plugins/test-harness.php file:
      """
      <?php
      $cache_post = function(){
        wp_cache_set( 'post_123', array( 'ID' => 123, 'post_title' => 'Test' ), 'posts' );
        wp_cache_set( 'meta_123', array( 'key' => 'value' ), 'post_meta' );
      };
      WP_CLI::add_hook( 'before_invoke:cache flush-post', $cache_post );
      """

    When I run `wp cache flush-post`
    Then STDOUT should contain:
      """
      Success: Post caches cleared.
      """

    When I run `wp cache flush-post 123`
    Then STDOUT should contain:
      """
      Success: Post cache for ID 123 cleared.
      """

  @skip-object-cache
  Scenario: Flush term cache
    Given a WP install
    And a wp-content/mu-plugins/test-harness.php file:
      """
      <?php
      $cache_term = function(){
        wp_cache_set( 'term_5', array( 'term_id' => 5 ), 'terms' );
        wp_cache_set( 'term_meta_5', array(), 'term_meta' );
      };
      WP_CLI::add_hook( 'before_invoke:cache flush-term', $cache_term );
      """

    When I run `wp cache flush-term`
    Then STDOUT should contain:
      """
      Success: Term caches cleared.
      """

    When I run `wp cache flush-term 5`
    Then STDOUT should contain:
      """
      Success: Term cache for ID 5 cleared.
      """

  @skip-object-cache
  Scenario: Flush comment cache
    Given a WP install
    And a wp-content/mu-plugins/test-harness.php file:
      """
      <?php
      $cache_comment = function(){
        wp_cache_set( 'comment_42', array(), 'comment' );
        wp_cache_set( 'comment_meta_42', array(), 'comment_meta' );
      };
      WP_CLI::add_hook( 'before_invoke:cache flush-comment', $cache_comment );
      """

    When I run `wp cache flush-comment`
    Then STDOUT should contain:
      """
      Success: Comment caches cleared.
      """

    When I run `wp cache flush-comment 42`
    Then STDOUT should contain:
      """
      Success: Comment cache for ID 42 cleared.
      """

  @skip-object-cache
  Scenario: Flush user cache
    Given a WP install
    And a wp-content/mu-plugins/test-harness.php file:
      """
      <?php
      $cache_user = function(){
        wp_cache_set( 'user_1', array( 'ID' => 1 ), 'users' );
        wp_cache_set( 'user_meta_1', array(), 'user_meta' );
      };
      WP_CLI::add_hook( 'before_invoke:cache flush-user', $cache_user );
      """

    When I run `wp cache flush-user`
    Then STDOUT should contain:
      """
      Success: User caches cleared.
      """

    When I run `wp cache flush-user 1`
    Then STDOUT should contain:
      """
      Success: User cache for ID 1 cleared.
      """

  @skip-object-cache
  Scenario: Flush option cache
    Given a WP install
    And a wp-content/mu-plugins/test-harness.php file:
      """
      <?php
      $cache_option = function(){
        wp_cache_set( 'my_option', 'value', 'options' );
        wp_cache_set( 'alloptions', array( 'my_option' => 'value' ), 'options' );
      };
      WP_CLI::add_hook( 'before_invoke:cache flush-option', $cache_option );
      """

    When I run `wp cache flush-option`
    Then STDOUT should contain:
      """
      Success: Option caches cleared.
      """

    When I run `wp cache flush-option my_option`
    Then STDOUT should contain:
      """
      Success: Option cache for 'my_option' cleared.
      """
