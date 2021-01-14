{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2018-2019 Vitalii Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 * @brief Journal landing page
 *
 *}

{extends "frontend/layouts/general.tpl"}

{* passing variable *}
{assign var="pageTitleTranslated" value=$currentJournal->getLocalizedName()}

{block name="pageContent"}
	{if !empty($latestIssues)}
		<section class="box_primary">
			<div class="container carousel-container">
				<div id="carouselIssues"
				     class="carousel slide carousel-fade"
				     data-ride="carousel">
					<div class="carousel-inner">
						{foreach from=$latestIssues item=issue key=latestKey}
							<div class="carousel-item{if $latestKey==0} active{/if}{if $issue->getLocalizedDescription()} carousel-with-caption{/if}">
								{if $issue->getLocalizedCoverImageUrl()}
									{assign var="coverUrl" value=$issue->getLocalizedCoverImageUrl()}
								{else}
									{assign var="coverUrl" value=$defaultCoverImageUrl}
								{/if}
								<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}"
								   class="carousel-img">
									<img src="{$coverUrl}"
									     class="img-fluid d-block{if !$issue->getLocalizedDescription()} m-auto{/if}"{if $issue->getLocalizedCoverImageAltText()} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
								</a>
								{if $issue->getLocalizedDescription()}
									<div class="carousel-caption">
										<a class="caption-header"
										   href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
											<h5>{$issue->getIssueIdentification()|escape}</h5>
										</a>

										<div class="carousel-text">
											{$issue->getLocalizedDescription()|strip_unsafe_html}
										</div>
									</div>
								{/if}
							</div>
						{/foreach}
					</div>

					{if $latestIssues|count > 1}
						<a class="carousel-control-prev" href="#carouselIssues" role="button" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">{translate key="help.previous"}</span>
						</a>
						<a class="carousel-control-next" href="#carouselIssues" role="button" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">{translate key="help.next"}</span>
						</a>
					{/if}
				</div>
			</div>
		</section>
	{/if}



	{if ($numAnnouncementsHomepage && $announcements|@count)}
		<section class="container index-journal__announcements">
			<div class="row">
				{if ($numAnnouncementsHomepage && $announcements|@count)}
					<h2 class="list-content__title col-md-12">
                        {translate key="announcement.announcements"}
					</h2>
					{foreach name=announcements from=$announcements item=announcement}
						{if $smarty.foreach.announcements.iteration > $numAnnouncementsHomepage}
							{break}
						{/if}

						{if $smarty.foreach.announcements.iteration == 1}
							<article class="list-content__announcement first col-md-6">
								<h3 class="list-content__announcement-title">
									<a class="list-content__announcement-link"
									   href="{url page="announcement" op="view" path=$announcement->getId()}">
										{$announcement->getLocalizedTitle()|escape}
									</a>
									<small class="mt-2 text-muted d-block">
										{$announcement->getDatePosted()}
									</small>
								</h3>
								{if $announcement->getLocalizedDescriptionShort()}
									<div class="list-content__announcement-description">
										{$announcement->getLocalizedDescriptionShort()|strip_unsafe_html}
									</div>
								{elseif $announcement->getLocalizedDescription()}
									<div class="list-content__announcement-description">
										{$announcement->getLocalizedDescription()|strip_unsafe_html|truncate:500:"..."}
									</div>
								{/if}
							</article>
						{/if}
						{if $smarty.foreach.announcements.iteration == 2}
							<ul class="list-content col-md-6">
							{assign var="moreThanOneAnnouncement" value=true}
						{/if}

						{if $smarty.foreach.announcements.iteration > 1}
							<li class="list-content__announcement">
								<h3 class="list-content__announcement-title">
									<a class="list-content__announcement-link"
									   href="{url page="announcement" op="view" path=$announcement->getId()}">
										{$announcement->getLocalizedTitle()|escape}
									</a>
									<small class="mt-2 text-muted d-block">
										{$announcement->getDatePosted()}
									</small>
								</h3>
							</li>
						{/if}
					{/foreach}
					{if $moreThanOneAnnouncement}
						</ul>
					{/if}
				{/if}
			</div>
		</section>
	{/if}
	<div class="row">
		<div class="col-md-8">
			<div class="row">
				{if $showSummary}
					<section class="container index-journal__desc">
						<div class="row justify-content-center">
							{assign var="thumb" value=$currentJournal->getLocalizedData('journalThumbnail')}
							{if $thumb}
								<div class="col-md-12">
									{capture assign="url"}{url journal=$currentJournal->getPath()}{/capture}
									<img class="img-fluid" src="{$journalFilesPath}{$currentJournal->getId()}/{$thumb.uploadName|escape:"url"}"{if $thumb.altText} alt="{$thumb.altText|escape|default:''}"{/if}>
								</div>
							{/if}
							<div class="col-md-12">
								{$currentJournal->getLocalizedSetting("description")}
							</div>
						</div>
					</section>
				{/if}
				{if !empty($publishedArticles) || !empty($popularArticles)}
					
					<section class="container{if !empty($categories) && $numCategoriesHomepage} no-border{/if}">
						<div class="row justify-content-center">
							<div class="recent-articles-section-title col-md-12">
								<h3 class="list-content__title">{translate key="plugins.gregg.latest"}</h3>
							</div>
							
							{if !empty($publishedArticles)}
								<div class="row">
									{foreach from=$publishedArticles item="publishedArticle" key="number"}
										<div class="recent-wrapper col-md-6">
											<div class="card">
												<div class="card-body">
													<h4 class="card-title">
														<a class="recent-article-title"
														   href="{url page="article" op="view" path=$publishedArticle->getBestArticleId()}">
															{$publishedArticle->getLocalizedTitle()|strip_unsafe_html}
														</a>
													</h4>
													<p class="card-text">
														{foreach from=$publishedArticle->getAuthors() key=k item="publishedAuthor"}
															<span>{$publishedAuthor->getFullName()|escape}
																
														{/foreach}
													</p>
												</div>
												<div class="card-footer">
													<small class="text-muted">
														{translate key="submissions.published"}
										:
														{$publishedArticle->getDatePublished()|date_format:"%Y-%m-%d"}
													</small>
												</div>
											</div>
										</div>
										

									{/foreach}
								</div>
							{/if}
						</div>
					</section>
					
				{/if}
			</div>
		</div>
		<div class="col-md-4">
			{if $hasSidebar || $pageFooter}
				<div class="pkp_structure_sidebar">
					{call_hook name="Templates::Common::Sidebar"}
				</div>
			{/if}
		</div>
	</div>
	

	{if !empty($categories) && $numCategoriesHomepage}
		<section class="box_primary index-journal__categories-header">
			<h2>
				{translate key="plugins.gregg.journal.categories.title"}
			</h2>
		</section>

		<section class="container index-journal__categories">
			<div class="row">
				{foreach from=$categories item=category key=numCategory}
					{if $numCategory+1 > $numCategoriesHomepage}
						{break}
					{/if}
					{capture assign=categoryUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()}{/capture}

					<div class="col-md-6 grid-item">
						{if $category->getLocalizedTitle()}
							<a class="index-journal__categories-title-wrapper" href="{$categoryUrl}">
								<h3 class="index-journal__categories-title">{$category->getLocalizedTitle()|escape}</h3>
							</a>
						{/if}
						{if $category->getImage()}
							<div class="index-journal__categories-img-wrapper">
								<a class="image" href="{$categoryUrl}">
									<img class="img-thumbnail" src="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="fullSize" type="category" id=$category->getId()}" alt="{$category->getLocalizedTitle()|escape}" />
								</a>
							</div>
						{/if}
						{if $category->getLocalizedDescription()}
							<div class="index-journal__categories-desc">
								{$category->getLocalizedDescription()|strip_unsafe_html|truncate:400:"... <a href='{$categoryUrl}'>{translate key='plugins.themes.oldGregg.more'}</a>"}
							</div>
						{/if}

					</div>

				{/foreach}
			</div>
		</section>
	{/if}

	{capture assign="indexJournalHook"}{call_hook name="Templates::Index::journal"}{/capture}
	{if $indexJournalHook}
		<div class="container">
			{call_hook name="Templates::Index::journal"}
		</div>
	{/if}
{/block}

