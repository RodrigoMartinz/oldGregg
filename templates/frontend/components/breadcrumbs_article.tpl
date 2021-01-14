{**
 * templates/frontend/components/breadcrumbs_article.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko, MD
 *}

<nav class="bread-nav" aria-label="breadcrumb" role="navigation">
	<ol class="breadcrumb">
		<li class="breadcrumb-item" aria-current="page">
			<span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>
			<a href="{url page="index" router=$smarty.const.ROUTE_PAGE}">
				{translate key="common.homepageNavigationLabel"}
			</a>
		</li>
		<li class="breadcrumb-item" aria-current="page">
			<a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
				{translate key="navigation.archives"}
			</a>
		</li>
		<li class="breadcrumb-item" aria-current="page">
			<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
				{$issue->getIssueIdentification()}
			</a>
		</li>
		<li class="breadcrumb-item active" aria-current="page">
				{if $currentTitleKey}
					{translate key=$currentTitleKey}
				{else}
					{$currentTitle|escape}
				{/if}
		</li>
	</ol>
</nav>
<div class="buttons-wrapper row b-share">
	<div id="fb-root"></div>
	<script async defer crossorigin="anonymous" src="https://connect.facebook.net/es_ES/sdk.js#xfbml=1&version=v9.0" nonce="BbCsPrlH"></script>
	<!-- Load Facebook SDK for JavaScript -->
	<div class="col-sm social-buttons">
		<div class="fb-share-button">
			 <a href="http://www.facebook.com/sharer/sharer.php?u={$currentUrl}" target="_blank" class="btn btn-sm btn-facebook btn-circle facebook-share-button">
			</a> 
		</div>
		
		<div class="tw-share-button">
			<a class="btn btn-sm btn-twitter twitter-share-button"
				href="https://twitter.com/intent/tweet?text={$section->getLocalizedTitle()}"
				data-size="large">
				</a>
			
		</div>
		<div class="wp-share-button">
			<a class="btn btn-sm btn-whatsapp whatsapp-share-button"
				href="https://api.whatsapp.com/send?text={$currentUrl}" target="_blank">
				</a>
		</div>
	</div>
</div>
