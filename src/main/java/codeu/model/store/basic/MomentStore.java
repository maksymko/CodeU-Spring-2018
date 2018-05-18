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

package codeu.model.store.basic;

import codeu.model.data.Moment;
import codeu.model.store.persistence.PersistentDataStoreException;
import codeu.model.store.persistence.PersistentStorageAgent;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Store class that uses in-memory data structures to hold values and automatically loads from and
 * saves to PersistentStorageAgent. It's a singleton so all servlet classes can access the same
 * instance.
 */
public class MomentStore {

  /** Singleton instance of MomentStore. */
  private static MomentStore instance;

  /**
   * Returns the singleton instance of MomentStore that should be shared between all servlet
   * classes. Do not call this function from a test; use getTestInstance() instead.
   */
  public static MomentStore getInstance() {
    if (instance == null) {
      instance = new MomentStore(PersistentStorageAgent.getInstance());
    }
    return instance;
  }

  /**
   * Instance getter function used for testing. Supply a mock for PersistentStorageAgent.
   *
   * @param persistentStorageAgent a mock used for testing
   */
  public static MomentStore getTestInstance(PersistentStorageAgent persistentStorageAgent) {
    return new MomentStore(persistentStorageAgent);
  }

  /**
   * The PersistentStorageAgent responsible for loading Moments from and saving Moments to
   * Datastore.
   */
  private PersistentStorageAgent persistentStorageAgent;

  /** The in-memory list of Moments. */
  private List<Moment> moments;

  /** This class is a singleton, so its constructor is private. Call getInstance() instead. */
  private MomentStore(PersistentStorageAgent persistentStorageAgent) {
    this.persistentStorageAgent = persistentStorageAgent;
    moments = new ArrayList<>();
  }
  
  /** Add a new moment to the current set of moments known to the application. */
  public void addMoment(Moment moment) {
    moments.add(moment);
    persistentStorageAgent.writeThrough(moment);
  }

  /** Returns number of moments in database */
  public int getNumMoments() {
    return this.moments.size();
  }

  /** Sets the List of Moments stored by this MomentStore. */
  public void setMoments(List<Moment> moments) {
    this.moments = moments;
  }

  /**
   * Returns a copy of the list of all moments.
   */
  public List<Moment> getMoments() {
    return this.moments;
  }

  /**
   * Returns a copy of the list of moments published by a specific user
   */
  public List<Moment> getMomentsByUser(UUID userId) {

    try {
      return PersistentStorageAgent.getInstance().loadMomentsByUser(userId);
    } catch (PersistentDataStoreException e) {
      System.err.println("Server didn't start correctly. An error occurred during Datastore load!");
      System.err.println("This is usually caused by loading data that's in an invalid format.");
      System.err.println("Check the stack trace to see exactly what went wrong.");
      throw new RuntimeException(e);
    }
  }
}
