/*
 * Copyright 2012 JBoss Inc
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.overlord.sramp.ui.shared.rsvcs;

import java.util.List;

import org.overlord.sramp.ui.shared.beans.ArtifactSummary;

import com.google.gwt.user.client.rpc.AsyncCallback;

/**
 * Async version of {@link IQueryRemoteService}.
 *
 * @author eric.wittmann@redhat.com
 */
public interface IQueryRemoteServiceAsync {

	/**
	 * Async version of {@link IQueryRemoteService#findArtifacts(int, int)}
	 */
	public void findArtifacts(int page, int pageSize, AsyncCallback<List<ArtifactSummary>> callback);

}
