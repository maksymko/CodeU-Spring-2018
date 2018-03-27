// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** Servlet class responsible for loading test data. */
public class TestDataServlet extends BaseServlet {

  /**
   * This function fires when a user requests the /testdata URL. It simply forwards the request to
   * testdata.jsp.
   */
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    request.getRequestDispatcher("/WEB-INF/view/testdata.jsp").forward(request, response);
  }

  /**
   * This function fires when a user submits the testdata form. It loads test data if the user
   * clicked the confirm button.
   */
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    String confirmButton = request.getParameter("confirm");

    if (confirmButton != null) {
      userStore.loadTestData();
      conversationStore.loadTestData();
      messageStore.loadTestData();
    }

    response.sendRedirect("/");
  }
}
