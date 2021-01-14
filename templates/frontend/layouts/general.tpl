{**
 * templates/frontend/layouts/general.tpl
 *
 * Copyright (c) 2017-2019 Vitalii Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 * @brief Layout for a general page, includes header and footer
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
{strip}
	{* Determine whether a logo or title string is being displayed *}
	{assign var="showingLogo" value=true}
	{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
		{assign var="showingLogo" value=false}
	{/if}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

<div class="cmp_skip_to_content">
	<a class="sr-only" href="#header">{translate key="navigation.skip.main"}</a>
	<a class="sr-only" href="#content">{translate key="navigation.skip.nav"}</a>
	<a class="sr-only" href="#footer">{translate key="navigation.skip.footer"}</a>
</div>

{capture assign="homeUrl"}
	{if $currentContext && $multipleContexts}
		{url page="index" router=$smarty.const.ROUTE_PAGE}
	{else}
		{url context="index" router=$smarty.const.ROUTE_PAGE}
	{/if}
{/capture}

{capture name="branding"}
	{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
		<a href="{$homeUrl|trim}" class="is_img">
			<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
		</a>
	{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
		<a href="{$homeUrl|trim}" class="is_text">{$displayPageHeaderTitle}</a>
	{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_array($displayPageHeaderTitle)}
		<a href="{$homeUrl|trim}" class="is_img">
			<img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" alt="{$displayPageHeaderTitle.altText|escape}" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" />
		</a>
	{else}
		<a href="{$homeUrl|trim}" class="is_img">
			<img src="{$baseUrl}/templates/images/structure/logo.png" alt="{$applicationName|escape}" title="{$applicationName|escape}" width="180" height="90" />
		</a>
	{/if}
{/capture}

<header class="container-fluid">
	{* User navigation *}
	<nav class="usernav navbar navbar-expand navbar-light" aria-label="{translate|escape key="common.navigation.user"}">
		{load_menu name="user" id="navigationUser" liClass="profile"}
	</nav>
	<div class="row">
		{if $requestedOp == 'index'}
			<h1 class="journal_branding col-md-12">
				{$smarty.capture.branding}
			</h1>
		{else}
			<div class="journal_branding col-md-12">
				{$smarty.capture.branding}
			</div>
		{/if}

		<div class="navigation_wrapper col-md-12">
			{* Primary site navigation *}
			{capture assign="primaryMenu"}
				{load_menu name="primary" id="navigationPrimary"}
			{/capture}

			{if !empty(trim($primaryMenu))}
				<nav class="primaryNav navbar navbar-expand-lg navbar-light" aria-label="{translate|escape key="common.navigation.site"}">
					{* Primary navigation menu for current application *}
					{$primaryMenu}
				</nav>
			{/if}
		</div>
	</div>
	
	<!--->
	<div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <form class="input-group" action="{url page="search" op="search"}" method="post" role="search">
                        {csrf}
                        <input type="text" name="query" value="{$searchQuery|escape}" class="search-input-tag form-control"
                               placeholder="{translate key="plugins.gregg.search-text"}" aria-label="Search">
                        <span class="input-group-btn">
                            <button class="btn btn-secondary"
                                    type="submit">{translate key="plugins.gregg.search"}</button>
                        </span>
                    </form>
                </div>
            </div>
        </div>
</header>

<main class="page-content-main container">
	{block name="pageContent"}{/block}
</main>

{block name="pageFooter"}
    <div class="site-footer">
        <div class="container">
			<!--Modificacion de codigo -->
			<div class="row">
				{if $pageFooter}
					<div class="pkp_footer_content">
						{$pageFooter}
					</div>
				{/if}
			</div>
			<!-- Fin Modificacion codigo -->

        </div>
    </div><!-- pkp_structure_footer_wrapper -->
	<!-- menu footer -->
	<div class="menu-site-footer">
		<nav class="navbar navbar-expand-sm navbar-dark bg-dark" aria-label="Third navbar example">
			<div class="container-fluid">
			  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample03" aria-controls="navbarsExample03" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			  </button>
			  <div class="collapse navbar-collapse justify-content-md-center">
				<ul class="navbar-nav">
				  <li class="nav-item active">
					<a href="http://192.168.1.71/ehmc/index.php/ehm/about/contact" style="color: white;">
						Contacto
					</a>
				  </li>
				  <li class="nav-item">
					<a href="http://192.168.1.71/ehmc/index.php/ehm/information/readers">
						Para lectores/as
					</a>
				  </li>
				  <li class="nav-item">
					<a href="http://192.168.1.71/ehmc/index.php/ehm/information/authors">
						Para autores/as
					</a>
				  </li>
				  <li class="nav-item">
					<a href="http://192.168.1.71/ehmc/index.php/ehm/information/librarians">
						Para bibliotecarios/as
					</a>
				  </li>
				  <li class="nav-item">
					<a href="">
						Powered by PKP
					</a>
				  </li>
				  <li class="nav-item">
					<a href="https://github.com/Vitaliy-1/oldGregg">
						oldGregg
					</a>
				  </li>
				  
				</ul>

			  </div>
			</div>
		  </nav>
	</div>
			

{/block}

{load_script context="frontend" scripts=$scripts}
{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
