import { useState } from 'react';
import LoginPage from './components/LoginPage';
import PlayersPage from './components/PlayersPage';
import TournamentsPage from './components/TournamentsPage';
import DashboardPage from './components/DashboardPage';
import ReportsPage from './components/ReportsPage';

export interface Player {
  id: string;
  name: string;
  position: string;
  age: number;
  team: string;
}

export interface Tournament {
  id: string;
  name: string;
  startDate: string;
  endDate: string;
  status: 'upcoming' | 'ongoing' | 'completed';
  participants: number;
  winner?: string;
}
